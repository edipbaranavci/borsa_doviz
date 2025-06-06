part of 'crypto_cubit.dart';

class CryptoState extends Equatable {
  const CryptoState({
    this.isLoading = false,
    this.cryptoModelList,
    this.lastUpdateDate,
    this.favoriteCryptoModelList,
    this.favoriteModelList,
    this.isOpenSearchBar = false,
    this.searchedCryptoModelList,
    this.isConnectInternet,
  });

  final bool isLoading;
  final String? lastUpdateDate;
  final List<CryptoModel>? cryptoModelList;
  final List<CryptoModel>? favoriteCryptoModelList;
  final List<FavoriteModel>? favoriteModelList;
  final bool? isConnectInternet;

  final List<CryptoModel>? searchedCryptoModelList;
  final bool isOpenSearchBar;

  @override
  List<Object> get props => [
    isLoading,
    lastUpdateDate ?? '',
    cryptoModelList ?? [],
    favoriteCryptoModelList ?? [],
    favoriteModelList ?? [],
    isOpenSearchBar,
    searchedCryptoModelList ?? [],
    isConnectInternet ?? '',
  ];

  CryptoState copyWith({
    bool? isLoading,
    String? lastUpdateDate,
    List<CryptoModel>? cryptoModelList,
    List<CryptoModel>? favoriteCryptoModelList,
    List<FavoriteModel>? favoriteModelList,
    List<CryptoModel>? searchedCryptoModelList,
    bool? isOpenSearchBar,
    bool? isConnectInternet,
  }) {
    return CryptoState(
      isLoading: isLoading ?? this.isLoading,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      cryptoModelList: cryptoModelList ?? this.cryptoModelList,
      favoriteCryptoModelList:
          favoriteCryptoModelList ?? this.favoriteCryptoModelList,
      favoriteModelList: favoriteModelList ?? this.favoriteModelList,
      searchedCryptoModelList:
          searchedCryptoModelList ?? this.searchedCryptoModelList,
      isOpenSearchBar: isOpenSearchBar ?? this.isOpenSearchBar,
      isConnectInternet: isConnectInternet ?? this.isConnectInternet,
    );
  }
}

final class CryptoInitial extends CryptoState {}
