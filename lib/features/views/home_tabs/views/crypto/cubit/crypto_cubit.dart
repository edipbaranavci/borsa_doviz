import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/extensions/string/string_extension.dart';
import '../../../../../../core/models/crypto_model/crypto_model.dart';
import '../../../../../../core/models/favorite/favorite_model.dart';
import '../../../../../services/network_service/borsa_service.dart';
import '../../../../../services/storage_service/hive_manager.dart';

part 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  CryptoCubit() : super(CryptoInitial()) {
    init();
  }

  final _service = BorsaService();
  final _hiveManager = HiveManager();

  final searchController = TextEditingController();

  void init() async {
    await fetchCurrencies();
    await getLastUpdateDate();
    getFavorites();
  }

  void changeSearchedWord() {
    final word = searchController.text.toConvertEnglish(toLowrecase: true);
    final List<CryptoModel> searchedCurrencyModelList = [];
    final cryptoModelList = state.cryptoModelList ?? [];
    if (word.isNotEmpty) {
      for (final cryptoModel in cryptoModelList) {
        final name = (cryptoModel.name ?? '').toConvertEnglish(
          toLowrecase: true,
        );
        final code = (cryptoModel.code ?? '').toConvertEnglish(
          toLowrecase: true,
        );
        if (name.contains(word) || code.contains(word)) {
          searchedCurrencyModelList.add(cryptoModel);
        }
      }
    }
    emit(state.copyWith(searchedCryptoModelList: searchedCurrencyModelList));
  }

  void changeIsOpenSearchBar() {
    final value = !state.isOpenSearchBar;
    if (value == false) {
      searchController.clear();
      emit(state.copyWith(isOpenSearchBar: value, searchedCryptoModelList: []));
    }
    emit(state.copyWith(isOpenSearchBar: value));
  }

  void getFavorites() {
    final favoriteList = _hiveManager.getFavorites();
    final List<FavoriteModel> favoriteModelList = [];
    final cryptoModel = state.cryptoModelList ?? [];
    final List<CryptoModel> favoriteCryptoModelList = [];
    for (final favoriteModel in favoriteList) {
      for (final cryptoModel in cryptoModel) {
        if (favoriteModel.code == cryptoModel.code) {
          favoriteCryptoModelList.add(cryptoModel);
          favoriteModelList.add(favoriteModel);
        }
      }
    }
    emit(
      state.copyWith(
        favoriteCryptoModelList: favoriteCryptoModelList,
        favoriteModelList: favoriteModelList,
      ),
    );
  }

  Future<void> addFavorite(CryptoModel cryptoModel) async {
    final favoriteModel = FavoriteModel(
      code: cryptoModel.code ?? '',
      dateTime: DateTime.now(),
      addDateSelling: '${cryptoModel.tRYPrice} | ${cryptoModel.uSDPrice}',
      name: cryptoModel.name ?? '',
    );
    await _hiveManager.addFavoriteModel(favoriteModel);
    getFavorites();
  }

  Future<void> removeFavorite(CryptoModel cryptoModel) async {
    await _hiveManager.deleteFavorite(cryptoModel.code ?? '');
    getFavorites();
  }

  Future<void> getLastUpdateDate() async {
    final res = await _service.getLastUpdateDate();
    res.fold(
      (left) => null,
      (right) => emit(state.copyWith(lastUpdateDate: right)),
    );
  }

  Future<void> fetchCurrencies() async {
    changeIsLoading(true);
    final res = await _service.fetchCrypto();
    res.fold(
      (left) => null,
      (right) => emit(state.copyWith(cryptoModelList: right)),
    );
    changeIsLoading(false);
  }

  void changeIsLoading(bool isLoading) =>
      emit(state.copyWith(isLoading: isLoading));
}
