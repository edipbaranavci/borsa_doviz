import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../core/components/button/custom_icon_button.dart';
import '../core/constants/views/custom_list_lite_card_strings.dart';
import '../core/extensions/date/date_extension.dart';
import '../core/models/favorite/favorite_model.dart';

class CustomListTileCard extends StatelessWidget {
  CustomListTileCard({
    super.key,
    required this.isFavorited,
    this.favoriteModel,
    this.onTap,
    this.change,
    this.name,
    this.code,
    this.buying,
    this.addDate,
    this.addDateSelling,
    this.selling,
  });
  final bool isFavorited;
  final FavoriteModel? favoriteModel;
  final void Function()? onTap;
  final String? name;
  final String? code;
  final String? buying;
  final String? addDateSelling;
  final String? selling;
  final DateTime? addDate;

  final num? change;

  final _strings = CustomListLiteCardStrings.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildListTile(context),
          favoriteModel != null
              ? buildFavoritedColumn(context)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Column buildFavoritedColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildInfoRow(
          context,
          Icons.calendar_month,
          addDate.formatTurkishDateTime(),
        ),
        buildInfoRow(
          context,
          Icons.restore,
          '${favoriteModel?.addDateSelling}',
        ),
        context.sized.emptySizedHeightBoxLow,
      ],
    );
  }

  Widget buildInfoRow(BuildContext context, IconData iconData, String title) {
    return Padding(
      padding: context.padding.onlyLeftLow,
      child: Row(
        children: [
          Icon(
            iconData,
            color:
                context.general.appTheme.brightness == Brightness.dark
                    ? context.general.colorScheme.primary
                    : context.general.colorScheme.secondary,
          ),
          Padding(
            padding: context.padding.onlyLeftLow,
            child: Text(
              title,
              style: context.general.textTheme.bodySmall?.copyWith(
                color:
                    context.general.appTheme.brightness == Brightness.dark
                        ? context.general.colorScheme.primary
                        : context.general.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context) {
    return ListTile(
      contentPadding: context.padding.low,
      title: buildCodeTitle(),
      subtitle: buildNameTitle(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildSellingTitle(context),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildBuyingTitle(context),
                  context.sized.emptySizedWidthBoxLow,
                  buildIcon(context),
                  Padding(
                    padding: context.padding.low * .4,
                    child: buildChangeTitle(context),
                  ),
                ],
              ),
            ],
          ),
          context.sized.emptySizedWidthBoxLow,
          buildFavoriteIcon(),
        ],
      ),
    );
  }

  CustomIconButton buildFavoriteIcon() {
    return CustomIconButton(
      iconData: isFavorited ? Icons.favorite : Icons.favorite_border,
      onTap: onTap,
      toolTip:
          isFavorited
              ? _strings.removeFavoriteTitle
              : _strings.addFavoriteTitle,
    );
  }

  Text buildChangeTitle(BuildContext context) {
    final itsUp = (change ?? 0) > 0;
    final itsEqual = (change ?? 0) == 0;
    return Text(
      '${change ?? 0}%',
      style: context.general.textTheme.bodyMedium?.copyWith(
        color:
            itsEqual
                ? context.general.colorScheme.primary
                : itsUp
                ? Colors.green
                : Colors.red,
      ),
    );
  }

  Icon buildIcon(BuildContext context) {
    final itsUp = (change ?? 0) > 0;
    final itsEqual = (change ?? 0) == 0;
    return Icon(
      itsEqual
          ? Icons.equalizer
          : itsUp
          ? Icons.keyboard_arrow_up
          : Icons.keyboard_arrow_down,
      size: context.sized.lowValue * 1.9,
      color:
          itsEqual
              ? context.general.colorScheme.primary
              : itsUp
              ? Colors.green
              : Colors.red,
    );
  }

  Text buildNameTitle() => Text(name ?? '');

  Text buildCodeTitle() => Text(code ?? '');

  Text buildBuyingTitle(BuildContext context) {
    return Text(
      buying ?? '',
      style: context.general.textTheme.bodySmall?.copyWith(
        color: context.general.colorScheme.secondary,
      ),
    );
  }

  Text buildSellingTitle(BuildContext context) {
    return Text(
      selling ?? '',
      textAlign: TextAlign.end,
      style: context.general.textTheme.bodyLarge?.copyWith(
        color: context.general.colorScheme.primary,
      ),
    );
  }
}
