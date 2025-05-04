import 'package:borsa_doviz/private/custom_list_tile_card.dart';

import '../../../../../../core/components/button/custom_elevated_text_button.dart';
import '../../../../../../core/components/dialog/custom_dialog.dart';
import '../../../../../../core/components/text_field/general_form_field.dart';
import '../../../../../../core/constants/views/doviz_view_strings.dart';
import '../../../../../../core/models/currency/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../../private/custom_title_text.dart';
import '../../../../../../private/custom_text.dart';
import '../cubit/doviz_cubit.dart';

part '../view_models/dialog.dart';

class DovizView extends StatelessWidget {
  const DovizView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DovizCubit>(
      create: (context) => DovizCubit(),
      child: const _DovizView(),
    );
  }
}

class _DovizView extends StatelessWidget {
  const _DovizView();

  void openDialog(BuildContext context, DovizCubit cubit) {
    showDialog(
      context: context,
      builder:
          (context) => BlocProvider.value(
            value: cubit,
            child: const _ConnectionDialog(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DovizCubit>();
    return Scaffold(
      key: cubit.scaffoldKey,
      appBar: AppBar(
        title: Text(DovizViewStrings.instance.pageTitle),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSearchBar(cubit),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => cubit.init(),
              child: BlocConsumer<DovizCubit, DovizState>(
                listener: (context, state) {
                  if (state.isConnectInternet == false) {
                    openDialog(context, cubit);
                  }
                },
                builder: (context, state) {
                  final list = state.currencyModelList ?? [];
                  final searchedList = state.searchedCurrencyModelList ?? [];
                  final favoritedList = state.favoriteCurrencyModelList ?? [];
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
                            title: DovizViewStrings.instance.generalListTitle,
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
    List<CurrencyModel> list,
    List<CurrencyModel> favoritedList,
    DovizCubit cubit,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(list.length, (index) {
        final model = list[index];
        final isFavorited = favoritedList.contains(model);
        return CustomListTileCard(
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
        );
      }),
    );
  }

  Widget buildSearchBar(DovizCubit cubit) {
    return BlocBuilder<DovizCubit, DovizState>(
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
                            '${DovizViewStrings.instance.lastUpdateTitle} ${state.lastUpdateDate ?? 'Yükleniyor...'}',
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

  Card buildFormField(BuildContext context, DovizCubit cubit) {
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

  Card buildSearchButton(bool isOpenSearchBar, DovizCubit cubit) {
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
    return BlocBuilder<DovizCubit, DovizState>(
      builder: (context, state) {
        final cubit = context.read<DovizCubit>();
        final favoriteCurrencyModelList = state.favoriteCurrencyModelList ?? [];
        final favoriteModelList = state.favoriteModelList ?? [];
        if (favoriteCurrencyModelList.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTitleText(
                title: DovizViewStrings.instance.addedFavoriteTitle,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(favoriteCurrencyModelList.length, (
                  index,
                ) {
                  return CustomListTileCard(
                    change: favoriteCurrencyModelList[index].change,
                    code: favoriteCurrencyModelList[index].code,
                    name: favoriteCurrencyModelList[index].name,
                    selling: favoriteCurrencyModelList[index].selling,
                    buying: favoriteCurrencyModelList[index].buying,
                    onTap:
                        () => cubit.removeFavorite(
                          favoriteCurrencyModelList[index],
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
