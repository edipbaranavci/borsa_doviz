import 'package:borsa_doviz/core/extensions/string/string_extension.dart';
import 'package:borsa_doviz/core/models/favorite/favorite_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/gold/gold_model.dart';
import '../../../../../services/network_service/borsa_service.dart';
import '../../../../../services/storage_service/hive_manager.dart';

part 'golds_state.dart';

class GoldsCubit extends Cubit<GoldsState> {
  GoldsCubit() : super(GoldsInitial()) {
    init();
  }

  final _service = BorsaService();
  final _hiveManager = HiveManager();
  final searchController = TextEditingController();

  void init() async {
    await fetchGold();
    await getLastUpdateDate();
    getFavorites();
  }

  void changeSearchedWord() {
    final word = searchController.text.toConvertEnglish(toLowrecase: true);
    final List<GoldModel> searchedGoldModelList = [];
    final goldModelList = state.goldModelList ?? [];
    if (word.isNotEmpty) {
      for (final currencyModel in goldModelList) {
        final name = (currencyModel.name ?? '').toConvertEnglish(
          toLowrecase: true,
        );
        final code = (currencyModel.code ?? '').toConvertEnglish(
          toLowrecase: true,
        );
        if (name.contains(word) || code.contains(word)) {
          searchedGoldModelList.add(currencyModel);
        }
      }
    }
    emit(state.copyWith(searchedGoldModelList: searchedGoldModelList));
  }

  void changeIsOpenSearchBar() {
    final value = !state.isOpenSearchBar;
    if (value == false) {
      searchController.clear();
      emit(state.copyWith(isOpenSearchBar: value, searchedGoldModelList: []));
    }
    emit(state.copyWith(isOpenSearchBar: value));
  }

  void getFavorites() {
    final favoriteList = _hiveManager.getFavorites();
    final List<FavoriteModel> favoriteModelList = [];
    final goldModelList = state.goldModelList ?? [];
    final List<GoldModel> favoriteGoldModelList = [];
    for (final favoriteModel in favoriteList) {
      for (final goldModel in goldModelList) {
        if (favoriteModel.code == goldModel.code) {
          favoriteGoldModelList.add(goldModel);
          favoriteModelList.add(favoriteModel);
        }
      }
    }
    emit(
      state.copyWith(
        favoriteGoldModelList: favoriteGoldModelList,
        favoriteModelList: favoriteModelList,
      ),
    );
  }

  Future<void> addFavorite(GoldModel goldModel) async {
    final favoriteModel = FavoriteModel(
      code: goldModel.code ?? '',
      dateTime: DateTime.now(),
      addDateSelling: goldModel.selling,
      name: goldModel.name ?? '',
    );
    await _hiveManager.addFavoriteModel(favoriteModel);
    getFavorites();
  }

  Future<void> removeFavorite(GoldModel goldModel) async {
    await _hiveManager.deleteFavorite(goldModel.code ?? '');
    getFavorites();
  }

  Future<void> getLastUpdateDate() async {
    final res = await _service.getLastUpdateDate();
    res.fold(
      (left) => null,
      (right) => emit(state.copyWith(lastUpdateDate: right)),
    );
  }

  Future<void> fetchGold() async {
    changeIsLoading(true);
    final res = await _service.fetchGold();
    res.fold(
      (left) => null,
      (right) => emit(state.copyWith(goldModelList: right)),
    );
    changeIsLoading(false);
  }

  void changeIsLoading(bool isLoading) =>
      emit(state.copyWith(isLoading: isLoading));
}
