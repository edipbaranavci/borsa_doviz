part of 'home_tabs_cubit.dart';

class HomeTabsState extends Equatable {
  const HomeTabsState({this.isConnectInternet});

  final bool? isConnectInternet;

  @override
  List<Object> get props => [isConnectInternet ?? ''];

  HomeTabsState copyWith({bool? isConnectInternet}) {
    return HomeTabsState(
      isConnectInternet: isConnectInternet ?? this.isConnectInternet,
    );
  }
}

final class HomeTabsInitial extends HomeTabsState {}
