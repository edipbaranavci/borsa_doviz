import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial()) {
    _init();
  }

  // final String _intersititialAdId = 'ca-app-pub-7487352118674207/3746515767';
  final String _bannerAdsId = 'ca-app-pub-7487352118674207/1655949131';
  // final String _bannerAdsId = 'ca-app-pub-3940256099942544/6300978111';

  void _init() async {
    await _loadBannerAds();
  }

  Future<void> _loadBannerAds() async {
    try {
      final bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: _bannerAdsId,
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) async {
            Logger().e(error.message);
            await ad.dispose();
          },
        ),
        request: const AdRequest(),
      );
      emit(state.copyWith(bannerAd: bannerAd));
      if (state.bannerAd != null) {
        await state.bannerAd?.load().whenComplete(() async {
          await Future.delayed(Duration(seconds: 60)).whenComplete(() async {
            await _loadInterSititialAd();
          });
        });
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<void> _loadInterSititialAd() async {
    return;
    // try {
    //   InterstitialAd.load(
    //     adUnitId: _intersititialAdId,
    //     request: const AdRequest(),
    //     adLoadCallback: InterstitialAdLoadCallback(
    //       // Called when an ad is successfully received.
    //       onAdLoaded: (ad) async {
    //         // Keep a reference to the ad so you can show it later.
    //         emit(state.copyWith(interstitialAd: ad));
    //         await ad.show();
    //       },
    //       // Called when an ad request failed.
    //       onAdFailedToLoad: (LoadAdError error) {},
    //     ),
    //   );
    // } catch (e) {
    //   Logger().e(e.toString());
    // }
  }
}
