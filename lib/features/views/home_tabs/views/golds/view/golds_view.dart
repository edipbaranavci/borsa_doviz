import 'package:borsa_doviz/private/ads/view/ads_view.dart';
import 'package:borsa_doviz/private/dialog/internet_connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../../core/components/text_field/general_form_field.dart';
import '../../../../../../core/constants/views/golds_view_strings.dart';
import '../../../../../../core/models/gold/gold_model.dart';
import '../../../../../../private/custom_list_tile_card.dart';
import '../../../../../../private/custom_text.dart';
import '../../../../../../private/custom_title_text.dart';
import '../cubit/golds_cubit.dart';

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

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ConnectionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GoldsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(GoldsViewStrings.instance.pageTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildSearchBar(cubit),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => cubit.init(),
              child: BlocConsumer<GoldsCubit, GoldsState>(
                listener: (context, state) {
                  if (state.isConnectInternet == false) {
                    openDialog(context);
                  }
                },
                builder: (context, state) {
                  final list = state.goldModelList ?? [];
                  final searchedList = state.searchedGoldModelList ?? [];
                  final favoritedList = state.favoriteGoldModelList ?? [];
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
                            title: GoldsViewStrings.instance.generalListTitle,
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
    List<GoldModel> list,
    List<GoldModel> favoritedList,
    GoldsCubit cubit,
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
              selling: model.selling,
              buying: model.buying,
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

  Widget buildSearchBar(GoldsCubit cubit) {
    return BlocBuilder<GoldsCubit, GoldsState>(
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
                            '${GoldsViewStrings.instance.lastUpdateTitle}\n${state.lastUpdateDate ?? 'Yükleniyor...'}',
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

  Card buildFormField(BuildContext context, GoldsCubit cubit) {
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

  Card buildSearchButton(bool isOpenSearchBar, GoldsCubit cubit) {
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
    return BlocBuilder<GoldsCubit, GoldsState>(
      builder: (context, state) {
        final cubit = context.read<GoldsCubit>();
        final favoriteGoldModelList = state.favoriteGoldModelList ?? [];
        final favoriteModelList = state.favoriteModelList ?? [];
        if (favoriteGoldModelList.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTitleText(
                title: GoldsViewStrings.instance.addedFavoriteTitle,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(favoriteGoldModelList.length, (index) {
                  final model = favoriteGoldModelList[index];
                  return CustomListTileCard(
                    change: model.change,
                    code: model.code,
                    name: model.name,
                    selling: model.selling,
                    buying: model.buying,
                    onTap: () => cubit.removeFavorite(model),
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
