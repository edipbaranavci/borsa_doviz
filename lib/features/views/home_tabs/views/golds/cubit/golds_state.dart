// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'golds_cubit.dart';

class GoldsState extends Equatable {
  const GoldsState({
    this.isLoading = true,
    this.goldModelList,
    this.isOpenSearchBar = false,
    this.searchedGoldModelList,
    this.lastUpdateDate,
    this.favoriteGoldModelList,
    this.favoriteModelList,
    this.isConnectInternet,
  });

  final bool isLoading;
  final List<GoldModel>? goldModelList;
  final String? lastUpdateDate;
  final List<GoldModel>? favoriteGoldModelList;
  final List<FavoriteModel>? favoriteModelList;
  final List<GoldModel>? searchedGoldModelList;
  final bool isOpenSearchBar;
  final bool? isConnectInternet;

  @override
  List<Object> get props => [
    isLoading,
    goldModelList ?? [],
    favoriteModelList ?? [],
    favoriteGoldModelList ?? [],
    lastUpdateDate ?? '',
    searchedGoldModelList ?? [],
    isOpenSearchBar,
    isConnectInternet ?? '',
  ];

  GoldsState copyWith({
    bool? isLoading,
    bool? isConnectInternet,
    List<GoldModel>? goldModelList,
    String? lastUpdateDate,
    List<GoldModel>? favoriteGoldModelList,
    List<FavoriteModel>? favoriteModelList,
    List<GoldModel>? searchedGoldModelList,
    bool? isOpenSearchBar,
  }) {
    return GoldsState(
      isLoading: isLoading ?? this.isLoading,
      goldModelList: goldModelList ?? this.goldModelList,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      favoriteGoldModelList:
          favoriteGoldModelList ?? this.favoriteGoldModelList,
      favoriteModelList: favoriteModelList ?? this.favoriteModelList,
      searchedGoldModelList:
          searchedGoldModelList ?? this.searchedGoldModelList,
      isOpenSearchBar: isOpenSearchBar ?? this.isOpenSearchBar,
      isConnectInternet: isConnectInternet ?? this.isConnectInternet,
    );
  }
}

final class GoldsInitial extends GoldsState {}
