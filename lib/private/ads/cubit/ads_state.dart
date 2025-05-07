part of 'ads_cubit.dart';

class AdsState extends Equatable {
  const AdsState({this.interstitialAd, this.bannerAd});

  final InterstitialAd? interstitialAd;

  final BannerAd? bannerAd;

  @override
  List<Object> get props => [interstitialAd ?? '', bannerAd ?? ''];

  AdsState copyWith({
    InterstitialAd? interstitialAd,
    bool? isLoading,
    BannerAd? bannerAd,
  }) {
    return AdsState(
      interstitialAd: interstitialAd ?? this.interstitialAd,
      bannerAd: bannerAd ?? this.bannerAd,
    );
  }
}

final class AdsInitial extends AdsState {}
