import '../../../../../../core/extensions/date/date_extension.dart';
import '../../../../../../core/models/crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../../core/models/favorite/favorite_model.dart';
import '../cubit/crypto_cubit.dart';

part '../view_models/card.dart';

class CryptoView extends StatelessWidget {
  const CryptoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoCubit>(
      create: (context) => CryptoCubit(),
      child: const _CryptoView(),
    );
  }
}

class _CryptoView extends StatelessWidget {
  const _CryptoView();

  final String pageTitle = 'Kripto';
  final String lastUpdateTitle = 'Son Güncellenme Tarihi: ';
  final String addedFavoriteTitle = 'Favoriye Eklenenler';
  final String generalListTitle = 'Genel Liste';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CryptoCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async => cubit.init(),
        child: BlocBuilder<CryptoCubit, CryptoState>(
          builder: (context, state) {
            final list = state.cryptoModelList ?? [];
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
                            _Card(cryptoModel: list[index], isFavorited: false),
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
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        final favoriteCryptoModelList = state.favoriteCryptoModelList ?? [];
        final favoriteModelList = state.favoriteModelList ?? [];
        if (favoriteCryptoModelList.isEmpty) {
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
                  favoriteCryptoModelList.length,
                  (index) => _Card(
                    cryptoModel: favoriteCryptoModelList[index],
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
