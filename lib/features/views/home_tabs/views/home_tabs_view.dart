import 'package:borsa_doviz/features/views/home_tabs/views/crypto/view/crypto_view.dart';
import 'package:borsa_doviz/features/views/home_tabs/views/doviz/view/doviz_view.dart';
import 'package:borsa_doviz/features/views/home_tabs/views/settings/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../cubit/home_tabs_cubit.dart';
import 'golds/view/golds_view.dart';

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
    return Scaffold(
      body: buildTabBarView(cubit),
      bottomNavigationBar: buildTabBar(context, cubit),
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
          Tab(text: 'Kripto', icon: Icon(Icons.currency_pound_outlined)),
          Tab(text: 'Ayarlar', icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
