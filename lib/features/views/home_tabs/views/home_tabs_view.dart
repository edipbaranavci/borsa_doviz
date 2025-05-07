import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../core/constants/views/home_tabs_view_strings.dart';
import '../cubit/home_tabs_cubit.dart';
import 'crypto/view/crypto_view.dart';
import 'doviz/view/doviz_view.dart';
import 'golds/view/golds_view.dart';
import 'settings/view/settings_view.dart';

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
        body: buildTabBarView(cubit),
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
        onTap: (value) => cubit.setTabIndex(value),
        isScrollable: false,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        splashBorderRadius: context.border.lowBorderRadius,
        unselectedLabelStyle: context.general.textTheme.bodySmall,
        labelStyle: context.general.textTheme.bodySmall,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(
            text: HomeTabsViewStrings.instance.dovizTitle,
            icon: Icon(Icons.money),
          ),
          Tab(
            text: HomeTabsViewStrings.instance.goldTitle,
            icon: Icon(Icons.g_mobiledata),
          ),
          Tab(
            text: HomeTabsViewStrings.instance.cryptoTitle,
            icon: Icon(Icons.currency_bitcoin),
          ),
          Tab(
            text: HomeTabsViewStrings.instance.settingsTitle,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
