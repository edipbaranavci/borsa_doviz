import 'package:borsa_doviz/core/extensions/scaffold_messenger/snack_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/currency/currency_model.dart';
import '../../../../../../core/models/favorite/favorite_model.dart';
import '../../../../../services/network_service/borsa_service.dart';
import '../../../../../services/storage_service/hive_manager.dart';

part 'doviz_state.dart';

class DovizCubit extends Cubit<DovizState> {
  DovizCubit() : super(DovizInitial()) {
    init();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _service = BorsaService();
  final _hiveManager = HiveManager();

  void init() async {
    await fetchCurrencies();
    await getLastUpdateDate();
    getFavorites();
  }

  void getFavorites() {
    final favoriteList = _hiveManager.getFavorites();
    final List<FavoriteModel> favoriteModelList = [];
    final currencyModel = state.currencyModelList ?? [];
    final List<CurrencyModel> favoriteCurrencyModelList = [];
    for (final favoriteModel in favoriteList) {
      for (final currencyModel in currencyModel) {
        if (favoriteModel.code == currencyModel.code) {
          favoriteCurrencyModelList.add(currencyModel);
          favoriteModelList.add(favoriteModel);
        }
      }
    }
    emit(
      state.copyWith(
        favoriteCurrencyModelList: favoriteCurrencyModelList,
        favoriteModelList: favoriteModelList,
      ),
    );
  }

  Future<void> addFavorite(CurrencyModel currencyModel) async {
    final favoriteModel = FavoriteModel(
      code: currencyModel.code ?? '',
      dateTime: DateTime.now(),
      addDateSelling: currencyModel.selling,
      name: currencyModel.name ?? '',
    );
    await _hiveManager.addFavoriteModel(favoriteModel);
    getFavorites();
  }

  Future<void> removeFavorite(CurrencyModel currencyModel) async {
    await _hiveManager.deleteFavorite(currencyModel.code ?? '');
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
    final res = await _service.fetchCurrency();
    res.fold(
      (left) => scaffoldKey.showErrorSnackBar(left.errorMessage),
      (right) => emit(state.copyWith(currencyModelList: right)),
    );
    changeIsLoading(false);
  }

  void changeIsLoading(bool isLoading) =>
      emit(state.copyWith(isLoading: isLoading));
}
