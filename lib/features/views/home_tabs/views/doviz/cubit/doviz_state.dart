// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doviz_cubit.dart';

class DovizState extends Equatable {
  const DovizState({
    this.favoriteModelList,
    this.favoriteCurrencyModelList,
    this.isLoading = true,
    this.lastUpdateDate,
    this.currencyModelList,
  });

  final bool isLoading;
  final List<CurrencyModel>? currencyModelList;
  final String? lastUpdateDate;
  final List<CurrencyModel>? favoriteCurrencyModelList;
  final List<FavoriteModel>? favoriteModelList;

  @override
  List<Object> get props => [
    isLoading,
    currencyModelList ?? [],
    lastUpdateDate ?? '',
    favoriteCurrencyModelList ?? [],
    favoriteModelList ?? [],
  ];

  DovizState copyWith({
    bool? isLoading,
    List<CurrencyModel>? currencyModelList,
    String? lastUpdateDate,
    List<CurrencyModel>? favoriteCurrencyModelList,
    List<FavoriteModel>? favoriteModelList,
  }) {
    return DovizState(
      isLoading: isLoading ?? this.isLoading,
      currencyModelList: currencyModelList ?? this.currencyModelList,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      favoriteCurrencyModelList:
          favoriteCurrencyModelList ?? this.favoriteCurrencyModelList,
      favoriteModelList: favoriteModelList ?? this.favoriteModelList,
    );
  }
}

final class DovizInitial extends DovizState {}
