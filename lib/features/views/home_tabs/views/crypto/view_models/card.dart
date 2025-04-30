part of '../view/crypto_view.dart';

class _Card extends StatelessWidget {
  const _Card({
    required this.cryptoModel,
    required this.isFavorited,
    this.favoriteModel,
  });
  final CryptoModel cryptoModel;
  final bool isFavorited;
  final FavoriteModel? favoriteModel;

  final String addFavoriteTitle = 'Favorilere Ekle';
  final String removeFavoriteTitle = 'Favorilerden Çıkar';
  final String addedFavoriteDateTitle = 'Favoriye Eklenme Tarihi: ';
  final String addedFavoriteSellingTitle =
      'Favoriye Eklendiğindeki Satış Fiyatı: ';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CryptoCubit>();

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildListTile(context, cubit),
          isFavorited
              ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: context.padding.onlyLeftLow,
                    child: Text(
                      '$addedFavoriteDateTitle ${favoriteModel?.dateTime?.formatTurkishDateTime()}',
                      style: context.general.textTheme.bodySmall?.copyWith(
                        color:
                            context.general.appTheme.brightness ==
                                    Brightness.dark
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
                            context.general.appTheme.brightness ==
                                    Brightness.dark
                                ? context.general.colorScheme.primary
                                : context.general.colorScheme.secondary,
                      ),
                    ),
                  ),
                  context.sized.emptySizedHeightBoxLow,
                ],
              )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, CryptoCubit cubit) {
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

  CustomIconButton buildFavoriteIcon(CryptoCubit cubit) {
    return CustomIconButton(
      iconData: isFavorited ? Icons.favorite : Icons.favorite_border,
      onTap: () {
        if (isFavorited) {
          cubit.removeFavorite(cryptoModel);
        } else {
          cubit.addFavorite(cryptoModel);
        }
      },
      toolTip: isFavorited ? removeFavoriteTitle : addFavoriteTitle,
    );
  }

  Text buildChangeTitle(BuildContext context) {
    final itsUp = (cryptoModel.change ?? 0) > 0;
    final itsEqual = (cryptoModel.change ?? 0) == 0;
    return Text(
      '${cryptoModel.change ?? 0}%',
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
    final itsUp = (cryptoModel.change ?? 0) > 0;
    final itsEqual = (cryptoModel.change ?? 0) == 0;
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

  Text buildNameTitle() => Text(cryptoModel.name ?? '');

  Text buildCodeTitle() => Text(cryptoModel.code ?? '');

  Text buildSellingTitle(BuildContext context) {
    return Text(
      '${cryptoModel.tRYPrice} | ${cryptoModel.uSDPrice}',
      textAlign: TextAlign.end,
      style: context.general.textTheme.bodyLarge?.copyWith(
        color: context.general.colorScheme.primary,
      ),
    );
  }
}
