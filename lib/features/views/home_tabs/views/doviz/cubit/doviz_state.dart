// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doviz_cubit.dart';

class DovizState extends Equatable {
  const DovizState({
    this.favoriteModelList,
    this.favoriteCurrencyModelList,
    this.isLoading = true,
    this.lastUpdateDate,
    this.currencyModelList,
    this.isOpenSearchBar = false,
    this.searchedCurrencyModelList,
    this.isConnectInternet,
  });

  final bool isLoading;
  final List<CurrencyModel>? currencyModelList;
  final String? lastUpdateDate;
  final List<CurrencyModel>? favoriteCurrencyModelList;
  final List<FavoriteModel>? favoriteModelList;
  final List<CurrencyModel>? searchedCurrencyModelList;
  final bool isOpenSearchBar;
  final bool? isConnectInternet;

  @override
  List<Object> get props => [
    isLoading,
    currencyModelList ?? [],
    lastUpdateDate ?? '',
    favoriteCurrencyModelList ?? [],
    favoriteModelList ?? [],
    isOpenSearchBar,
    searchedCurrencyModelList ?? [],
    isConnectInternet ?? false,
  ];

  DovizState copyWith({
    bool? isLoading,
    List<CurrencyModel>? currencyModelList,
    String? lastUpdateDate,
    List<CurrencyModel>? favoriteCurrencyModelList,
    List<FavoriteModel>? favoriteModelList,
    List<CurrencyModel>? searchedCurrencyModelList,
    bool? isOpenSearchBar,
    bool? isConnectInternet,
  }) {
    return DovizState(
      isLoading: isLoading ?? this.isLoading,
      currencyModelList: currencyModelList ?? this.currencyModelList,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      favoriteCurrencyModelList:
          favoriteCurrencyModelList ?? this.favoriteCurrencyModelList,
      favoriteModelList: favoriteModelList ?? this.favoriteModelList,
      searchedCurrencyModelList:
          searchedCurrencyModelList ?? this.searchedCurrencyModelList,
      isOpenSearchBar: isOpenSearchBar ?? this.isOpenSearchBar,
      isConnectInternet: isConnectInternet ?? this.isConnectInternet,
    );
  }
}

final class DovizInitial extends DovizState {}
