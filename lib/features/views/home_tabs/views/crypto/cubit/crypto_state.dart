// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crypto_cubit.dart';

class CryptoState extends Equatable {
  const CryptoState({
    this.isLoading = false,
    this.cryptoModelList,
    this.lastUpdateDate,
    this.favoriteCryptoModelList,
    this.favoriteModelList,
  });

  final bool isLoading;
  final String? lastUpdateDate;
  final List<CryptoModel>? cryptoModelList;
  final List<CryptoModel>? favoriteCryptoModelList;
  final List<FavoriteModel>? favoriteModelList;

  @override
  List<Object> get props => [
    isLoading,
    lastUpdateDate ?? '',
    cryptoModelList ?? [],
    favoriteCryptoModelList ?? [],
    favoriteModelList ?? [],
  ];

  CryptoState copyWith({
    bool? isLoading,
    String? lastUpdateDate,
    List<CryptoModel>? cryptoModelList,
    List<CryptoModel>? favoriteCryptoModelList,
    List<FavoriteModel>? favoriteModelList,
  }) {
    return CryptoState(
      isLoading: isLoading ?? this.isLoading,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      cryptoModelList: cryptoModelList ?? this.cryptoModelList,
      favoriteCryptoModelList:
          favoriteCryptoModelList ?? this.favoriteCryptoModelList,
      favoriteModelList: favoriteModelList ?? this.favoriteModelList,
    );
  }
}

final class CryptoInitial extends CryptoState {}
