import '../../../../../../private/ads/view/ads_view.dart';
import '../../../../../../private/custom_list_tile_card.dart';

import '../../../../../../core/constants/views/crypto_view_strings.dart';
import '../../../../../../private/custom_text.dart';
import '../../../../../../private/custom_title_text.dart';

import '../../../../../../core/components/text_field/general_form_field.dart';
import '../../../../../../core/models/crypto_model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../../private/dialog/internet_connection_dialog.dart';
import '../cubit/crypto_cubit.dart';

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

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ConnectionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CryptoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(CryptoViewStrings.instance.pageTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildSearchBar(cubit),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => cubit.init(),
              child: BlocConsumer<CryptoCubit, CryptoState>(
                listener: (context, state) {
                  if (state.isConnectInternet == false) {
                    openDialog(context);
                  }
                },
                builder: (context, state) {
                  final list = state.cryptoModelList ?? [];
                  final searchedList = state.searchedCryptoModelList ?? [];
                  final favoritedList = state.favoriteCryptoModelList ?? [];
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
                          buildFavoritesColumn(),
                          context.sized.emptySizedHeightBoxLow,
                          CustomTitleText(
                            title: CryptoViewStrings.instance.generalListTitle,
                          ),
                          context.sized.emptySizedHeightBoxLow,
                          buildColumn(
                            searchedList.isNotEmpty ? searchedList : list,
                            favoritedList,
                            cubit,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildColumn(
    List<CryptoModel> list,
    List<CryptoModel> favoritedList,
    CryptoCubit cubit,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(list.length, (index) {
        final model = list[index];
        final isFavorited = favoritedList.contains(model);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomListTileCard(
              isFavorited: favoritedList.contains(model),
              change: model.change,
              code: model.code,
              name: model.name,
              selling: '${model.tRYPrice} ${model.uSDPrice}',
              buying: '',
              onTap: () {
                if (isFavorited) {
                  cubit.removeFavorite(model);
                } else {
                  cubit.addFavorite(model);
                }
              },
            ),
            (index % 10 == 0 && index != 0)
                ? AdsView()
                : const SizedBox.shrink(),
          ],
        );
      }),
    );
  }

  Widget buildSearchBar(CryptoCubit cubit) {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            context.sized.emptySizedWidthBoxLow3x,
            Expanded(
              child:
                  state.isOpenSearchBar
                      ? buildFormField(context, cubit)
                      : CustomText(
                        title:
                            '${CryptoViewStrings.instance.lastUpdateTitle}\n${state.lastUpdateDate ?? 'Yükleniyor...'}',
                      ),
            ),
            context.sized.emptySizedWidthBoxLow,
            buildSearchButton(state.isOpenSearchBar, cubit),
            context.sized.emptySizedWidthBoxLow3x,
          ],
        );
      },
    );
  }

  Card buildFormField(BuildContext context, CryptoCubit cubit) {
    return Card(
      child: Padding(
        padding: context.padding.low,
        child: GeneralTextFormField(
          controller: cubit.searchController,
          keyboardType: TextInputType.text,
          onChanged: (_) => cubit.changeSearchedWord(),
        ),
      ),
    );
  }

  Card buildSearchButton(bool isOpenSearchBar, CryptoCubit cubit) {
    return Card(
      child: CustomIconButton(
        iconData: isOpenSearchBar ? Icons.close : Icons.search_outlined,
        onTap: () => cubit.changeIsOpenSearchBar(),
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
        final cubit = context.read<CryptoCubit>();
        final favoriteCryptoModelList = state.favoriteCryptoModelList ?? [];
        final favoriteModelList = state.favoriteModelList ?? [];
        if (favoriteCryptoModelList.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTitleText(
                title: CryptoViewStrings.instance.addedFavoriteTitle,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(favoriteCryptoModelList.length, (
                  index,
                ) {
                  final model = favoriteCryptoModelList[index];
                  return CustomListTileCard(
                    change: model.change,
                    code: model.code,
                    name: model.name,
                    selling: '${model.tRYPrice} ${model.uSDPrice}',
                    buying: '',
                    onTap:
                        () => cubit.removeFavorite(
                          favoriteCryptoModelList[index],
                        ),
                    isFavorited: true,
                    favoriteModel: favoriteModelList[index],
                    addDate: favoriteModelList[index].dateTime,
                    addDateSelling: favoriteModelList[index].addDateSelling,
                  );
                }),
              ),
            ],
          );
        }
      },
    );
  }
}
