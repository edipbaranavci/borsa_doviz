import '../../../../core/components/button/custom_elevated_text_button.dart';
import '../../../../core/components/dialog/custom_dialog.dart';

import 'crypto/view/crypto_view.dart';
import 'doviz/view/doviz_view.dart';
import 'settings/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:upgrader/upgrader.dart';

import '../cubit/home_tabs_cubit.dart';
import 'golds/view/golds_view.dart';

part '../viewModel/internet_dialog.dart';

class HomeTabsView extends StatefulWidget {
  const HomeTabsView({super.key});

  @override
  State<HomeTabsView> createState() => _HomeTabsViewState();
}

class _HomeTabsViewState extends State<HomeTabsView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeTabsCubit>(
      create: (context) => HomeTabsCubit(TabController(length: 4, vsync: this)),
      child: const _HomeTabsView(),
    );
  }
}

class _HomeTabsView extends StatelessWidget {
  const _HomeTabsView();

  void openDialog(BuildContext context, HomeTabsCubit cubit) {
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
    final cubit = context.read<HomeTabsCubit>();
    return UpgradeAlert(
      showIgnore: false,
      dialogStyle: UpgradeDialogStyle.cupertino,
      showLater: true,
      upgrader: Upgrader(
        languageCode: 'tr',
        countryCode: 'TR',
        durationUntilAlertAgain: const Duration(days: 0),
      ),
      showReleaseNotes: true,
      barrierDismissible: true,
      child: Scaffold(
        body: BlocListener<HomeTabsCubit, HomeTabsState>(
          listener: (context, state) {
            if (state.isConnectInternet == false) {
              openDialog(context, cubit);
            }
          },
          child: buildTabBarView(cubit),
        ),
        bottomNavigationBar: buildTabBar(context, cubit),
      ),
    );
  }

  TabBarView buildTabBarView(HomeTabsCubit cubit) {
    return TabBarView(
      controller: cubit.tabController,
      children: [DovizView(), GoldsView(), CryptoView(), SettingsView()],
    );
  }

  Widget buildTabBar(BuildContext context, HomeTabsCubit cubit) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      child: TabBar(
        controller: cubit.tabController,
        dividerColor: Colors.transparent,
        isScrollable: false,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        splashBorderRadius: context.border.lowBorderRadius,
        unselectedLabelStyle: context.general.textTheme.bodySmall,
        labelStyle: context.general.textTheme.bodySmall,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(text: 'Döviz', icon: Icon(Icons.money)),
          Tab(text: 'Altın', icon: Icon(Icons.g_mobiledata)),
          Tab(text: 'Kripto', icon: Icon(Icons.currency_bitcoin)),
          Tab(text: 'Ayarlar', icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
