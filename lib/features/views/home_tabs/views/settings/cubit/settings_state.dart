part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({this.appVersion});
  final String? appVersion;

  @override
  List<Object> get props => [appVersion ?? ''];

  SettingsState copyWith({String? appVersion}) {
    return SettingsState(appVersion: appVersion ?? this.appVersion);
  }
}

final class SettingsInitial extends SettingsState {}
