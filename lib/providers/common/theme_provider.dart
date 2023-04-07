import 'package:flutter/material.dart';
import 'package:the_better_life/configs/styles/theme.dart';
import 'package:the_better_life/utils/shared_preference.dart';

class ThemeManager with ChangeNotifier {
  ThemeManager() {
    _loadTheme();
  }

  ThemeData? _themeData;

  /// Use this method on UI to get selected theme.
  ThemeData? get themeData {
    _themeData ??= appThemeData[AppTheme.light];
    return _themeData;
  }

  /// Sets theme and notifies listeners about change.
  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme];
    // Here we notify listeners that theme changed
    // so UI have to be rebuild
    SharedPrefsService.setThemeMode(theme);
    notifyListeners();
  }

  void _loadTheme() async {
    _themeData = await SharedPrefsService.getThemeMode();
    notifyListeners();
  }
}
