import '../../../services/network_service/internet_connection_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_tabs_state.dart';

class HomeTabsCubit extends Cubit<HomeTabsState> {
  HomeTabsCubit(this.tabController) : super(HomeTabsInitial());
  final TabController tabController;

  final _internetConnectionService = InternetConnectionService();

  Future<void> checkInternetConnection() async {
    final control = await _internetConnectionService.checkInternetConnection();
    emit(state.copyWith(isConnectInternet: control));
  }
}
