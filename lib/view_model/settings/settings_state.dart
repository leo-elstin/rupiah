part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ThemeChanged extends SettingsState {
  final Brightness brightness;

  ThemeChanged({required this.brightness});
}
