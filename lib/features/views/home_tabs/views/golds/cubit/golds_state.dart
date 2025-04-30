// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'golds_cubit.dart';

class GoldsState extends Equatable {
  const GoldsState({
    this.isLoading = true,
    this.goldModelList,
    this.lastUpdateDate,
    this.favoriteGoldModelList,
    this.favoriteModelList,
  });

  final bool isLoading;
  final List<GoldModel>? goldModelList;
  final String? lastUpdateDate;
  final List<GoldModel>? favoriteGoldModelList;
  final List<FavoriteModel>? favoriteModelList;

  @override
  List<Object> get props => [
    isLoading,
    goldModelList ?? [],
    favoriteModelList ?? [],
    favoriteGoldModelList ?? [],
    lastUpdateDate ?? '',
  ];

  GoldsState copyWith({
    bool? isLoading,
    List<GoldModel>? goldModelList,
    String? lastUpdateDate,
    List<GoldModel>? favoriteGoldModelList,
    List<FavoriteModel>? favoriteModelList,
  }) {
    return GoldsState(
      isLoading: isLoading ?? this.isLoading,
      goldModelList: goldModelList ?? this.goldModelList,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      favoriteGoldModelList:
          favoriteGoldModelList ?? this.favoriteGoldModelList,
      favoriteModelList: favoriteModelList ?? this.favoriteModelList,
    );
  }
}

final class GoldsInitial extends GoldsState {}
