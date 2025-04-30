// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({this.themeMode = ThemeMode.system});
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  MainState copyWith({ThemeMode? themeMode}) {
    return MainState(themeMode: themeMode ?? this.themeMode);
  }
}

final class MainInitial extends MainState {}
