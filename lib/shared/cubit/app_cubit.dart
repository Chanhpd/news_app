import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/logger.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final SharedPreferences sharedPreferences;
  
  static const String themeModeKey = 'theme_mode';
  static const String localeKey = 'locale';

  AppCubit(this.sharedPreferences) : super(const AppState()) {
    _loadPreferences();
  }

  void _loadPreferences() {
    try {
      final themeModeIndex = sharedPreferences.getInt(themeModeKey);
      final localeCode = sharedPreferences.getString(localeKey);

      emit(state.copyWith(
        themeMode: themeModeIndex != null 
            ? ThemeMode.values[themeModeIndex]
            : ThemeMode.system,
        locale: localeCode != null 
            ? Locale(localeCode) 
            : const Locale('en'),
      ));
    } catch (e) {
      logger.e('Error loading preferences');
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      await sharedPreferences.setInt(themeModeKey, themeMode.index);
      emit(state.copyWith(themeMode: themeMode));
      logger.d('Theme mode changed to: $themeMode');
    } catch (e) {
      logger.e('Error setting theme mode');
    }
  }

  Future<void> setLocale(Locale locale) async {
    try {
      await sharedPreferences.setString(localeKey, locale.languageCode);
      emit(state.copyWith(locale: locale));
      logger.d('Locale changed to: ${locale.languageCode}');
    } catch (e) {
      logger.e('Error setting locale');
    }
  }
}
