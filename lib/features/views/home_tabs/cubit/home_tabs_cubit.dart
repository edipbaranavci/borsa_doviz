import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/storage_service/hive_manager.dart';

part 'home_tabs_state.dart';

class HomeTabsCubit extends Cubit<HomeTabsState> {
  HomeTabsCubit(this.tabController) : super(HomeTabsInitial()) {
    _init();
  }
  final TabController tabController;

  final _hiveManager = HiveManager();

  void _init() async {
    await getTabIndex();
  }

  void setTabIndex(int index) async {
    tabController.animateTo(index);
    await _hiveManager.saveTabIndexModel(index);
  }

  Future<void> getTabIndex() async {
    final res = await _hiveManager.getTabIndex();
    res.fold((left) => null, (right) => tabController.animateTo(right));
  }
}
