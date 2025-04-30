part of '../view/doviz_view.dart';

class _Card extends StatelessWidget {
  const _Card({
    required this.goldModel,
    required this.isFavorited,
    this.favoriteModel,
  });
  final CurrencyModel goldModel;
  final bool isFavorited;
  final FavoriteModel? favoriteModel;

  final String addFavoriteTitle = 'Favorilere Ekle';
  final String removeFavoriteTitle = 'Favorilerden Çıkar';
  final String addedFavoriteDateTitle = 'Favoriye Eklenme Tarihi: ';
  final String addedFavoriteSellingTitle =
      'Favoriye Eklendiğindeki Satış Fiyatı: ';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DovizCubit>();

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildListTile(context, cubit),
          isFavorited ? buildFavoritedColumn(context) : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Column buildFavoritedColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.padding.onlyLeftLow,
          child: Text(
            '$addedFavoriteDateTitle ${favoriteModel?.dateTime?.formatTurkishDateTime()}',
            style: context.general.textTheme.bodySmall?.copyWith(
              color:
                  context.general.appTheme.brightness == Brightness.dark
                      ? context.general.colorScheme.primary
                      : context.general.colorScheme.secondary,
            ),
          ),
        ),
        Padding(
          padding: context.padding.onlyLeftLow,
          child: Text(
            '$addedFavoriteSellingTitle ${favoriteModel?.addDateSelling}',
            style: context.general.textTheme.bodySmall?.copyWith(
              color:
                  context.general.appTheme.brightness == Brightness.dark
                      ? context.general.colorScheme.primary
                      : context.general.colorScheme.secondary,
            ),
          ),
        ),
        context.sized.emptySizedHeightBoxLow,
      ],
    );
  }

  ListTile buildListTile(BuildContext context, DovizCubit cubit) {
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
          buildFavoriteIcon(cubit),
        ],
      ),
    );
  }

  CustomIconButton buildFavoriteIcon(DovizCubit cubit) {
    return CustomIconButton(
      iconData: isFavorited ? Icons.favorite : Icons.favorite_border,
      onTap: () {
        if (isFavorited) {
          cubit.removeFavorite(goldModel);
        } else {
          cubit.addFavorite(goldModel);
        }
      },
      toolTip: isFavorited ? removeFavoriteTitle : addFavoriteTitle,
    );
  }

  Text buildChangeTitle(BuildContext context) {
    final itsUp = (goldModel.change ?? 0) > 0;
    final itsEqual = (goldModel.change ?? 0) == 0;
    return Text(
      '${goldModel.change ?? 0}%',
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
    final itsUp = (goldModel.change ?? 0) > 0;
    final itsEqual = (goldModel.change ?? 0) == 0;
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

  Text buildNameTitle() => Text(goldModel.name ?? '');

  Text buildCodeTitle() => Text(goldModel.code ?? '');

  Text buildBuyingTitle(BuildContext context) {
    return Text(
      goldModel.buying ?? '',
      style: context.general.textTheme.bodySmall?.copyWith(
        color: context.general.colorScheme.secondary,
      ),
    );
  }

  Text buildSellingTitle(BuildContext context) {
    return Text(
      goldModel.selling ?? '',
      textAlign: TextAlign.end,
      style: context.general.textTheme.bodyLarge?.copyWith(
        color: context.general.colorScheme.primary,
      ),
    );
  }
}
