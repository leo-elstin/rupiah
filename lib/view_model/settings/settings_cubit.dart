import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Brightness brightness = Brightness.light;

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getBool('isDark') == null) {
    //   prefs.setBool('isDark', false);
    // }
    if (prefs.getBool('isDark') ?? false) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }
    emit(ThemeChanged(brightness: brightness));
  }

  void changeBrightness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (brightness == Brightness.light) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }
    prefs.setBool('isDark', brightness == Brightness.light ? false : true);
    emit(ThemeChanged(brightness: brightness));
  }
}
