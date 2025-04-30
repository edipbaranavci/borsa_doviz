import '../../../../../../core/extensions/date/date_extension.dart';
import '../../../../../../core/models/favorite/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../../core/models/gold/gold_model.dart';
import '../cubit/golds_cubit.dart';

part '../view_models/card.dart';

class GoldsView extends StatelessWidget {
  const GoldsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoldsCubit>(
      create: (context) => GoldsCubit(),
      child: const _GoldsView(),
    );
  }
}

class _GoldsView extends StatelessWidget {
  const _GoldsView();

  final String pageTitle = 'Altın';
  final String lastUpdateTitle = 'Son Güncellenme Tarihi: ';
  final String addedFavoriteTitle = 'Favoriye Eklenenler';
  final String generalListTitle = 'Genel Liste';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GoldsCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async => cubit.init(),
        child: BlocBuilder<GoldsCubit, GoldsState>(
          builder: (context, state) {
            final list = state.goldModelList ?? [];
            if (state.isLoading) {
              return buildLoadingIndicator(context);
            } else {
              return SingleChildScrollView(
                padding: context.padding.low,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    context.sized.emptySizedHeightBoxLow,
                    Text(
                      '$lastUpdateTitle ${state.lastUpdateDate}',
                      textAlign: TextAlign.center,
                      style: context.general.textTheme.bodyMedium?.copyWith(
                        color:
                            context.general.appTheme.brightness ==
                                    Brightness.dark
                                ? context.general.colorScheme.primary
                                : context.general.colorScheme.secondary,
                      ),
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    buildFavoritesColumn(),
                    context.sized.emptySizedHeightBoxLow,
                    Padding(
                      padding: context.padding.low,
                      child: buildGeneralLitstTitle(context),
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        list.length,
                        (index) =>
                            _Card(goldModel: list[index], isFavorited: false),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Padding buildLoadingIndicator(BuildContext context) {
    return Padding(
      padding: context.padding.high,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildFavoritesColumn() {
    return BlocBuilder<GoldsCubit, GoldsState>(
      builder: (context, state) {
        final favoriteGoldModelList = state.favoriteGoldModelList ?? [];
        final favoriteModelList = state.favoriteModelList ?? [];
        if (favoriteGoldModelList.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: context.padding.low,
                child: buildAddedFavoriteTitle(context),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  favoriteGoldModelList.length,
                  (index) => _Card(
                    goldModel: favoriteGoldModelList[index],
                    isFavorited: true,
                    favoriteModel: favoriteModelList[index],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Text buildAddedFavoriteTitle(BuildContext context) {
    return Text(
      addedFavoriteTitle,
      textAlign: TextAlign.left,
      style: context.general.textTheme.titleLarge?.copyWith(
        color:
            context.general.appTheme.brightness == Brightness.dark
                ? context.general.colorScheme.primary
                : context.general.colorScheme.onPrimary,
      ),
    );
  }

  Text buildGeneralLitstTitle(BuildContext context) {
    return Text(
      generalListTitle,
      textAlign: TextAlign.left,
      style: context.general.textTheme.titleLarge?.copyWith(
        color:
            context.general.appTheme.brightness == Brightness.dark
                ? context.general.colorScheme.primary
                : context.general.colorScheme.onPrimary,
      ),
    );
  }
}
