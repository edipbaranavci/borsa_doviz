import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';

import '../cubit/ads_cubit.dart';

class AdsView extends StatelessWidget {
  const AdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdsCubit>(
      create: (context) => AdsCubit(),
      child: const _AdsView(),
    );
  }
}

class _AdsView extends StatelessWidget {
  const _AdsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
        final bannerAd = state.bannerAd;
        if (bannerAd == null) {
          return const SizedBox.shrink();
        } else {
          return Padding(
            padding: context.padding.low,
            child: Card(
              child: Padding(
                padding: context.padding.low,
                child: SizedBox(
                  height: (bannerAd.size.height).toDouble(),
                  width: (bannerAd.size.width).toDouble(),
                  child: AdWidget(ad: bannerAd),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
