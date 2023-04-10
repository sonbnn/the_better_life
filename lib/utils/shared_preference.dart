import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_better_life/configs/styles/theme.dart';
import 'package:the_better_life/features/drink_water/model/user.dart';
import 'package:the_better_life/features/drink_water/model/watter_history.dart';

class SharedPrefsService {
  // common
  static void addLanguageCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', code);
  }

  static Future<String> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }

  static void setThemeMode(AppTheme theme) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', AppTheme.values.indexOf(theme));
  }

  static Future<ThemeData> getThemeMode() async {
    var prefs = await SharedPreferences.getInstance();
    int preferredTheme = prefs.getInt('themeMode') ?? 0;
    ThemeData _themeData = appThemeData[AppTheme.values[preferredTheme]]!;
    return _themeData;
  }

  static Future<Map> getLanguages() async {
    var prefs = await SharedPreferences.getInstance();
    String languages = prefs.getString('languages') ?? '';
    Map<String, String> map = Map.castFrom(json.decode(languages));
    return map;
  }

  static Future setLanguages(Map languages) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languages', jsonEncode(languages));
  }

  static Future setAskingForUpdate(bool isOpen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAskingForUpdate', isOpen);
  }

  static Future<bool> getAskingForUpdate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isAskingForUpdate') ?? true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  static Future<bool> getFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('FirstTime') ?? true;
  }

  static Future setFirstTime({bool? value}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('FirstTime', value ?? false);
  }

  static Future<bool?> getCheckAlreadyPassWord() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AlreadyPassWord');
  }

  static Future setCheckAlreadyPassWord(bool status) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('AlreadyPassWord', status);
  }

  // water
  static Future<void> saveUserInfo(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', jsonEncode(user));
  }

  static Future<User> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = {};
    final String? info = prefs.getString('userInfo');
    if (info != null) {
      userMap = jsonDecode(info) as Map<String, dynamic>;
    }
    final User userInfo = User.fromJson(userMap);
    return userInfo;
  }

  static void setAmountDrinkToday(double currentMilli) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("amountDrinkToDay", currentMilli);
  }

  static Future<double> getAmountDrinkToday() async {
    var prefs = await SharedPreferences.getInstance();
    double? waterData = prefs.getDouble("amountDrinkToDay") ?? 0;
    return waterData;
  }


  static Future<void> saveDayHistory(List<WaterHistoryDay> historyDay) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('historyDay', jsonEncode(historyDay));
  }

  static Future<List<WaterHistoryDay>> getDayHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? info = prefs.getString('historyDay');
    final List<WaterHistoryDay> historyDay = WaterHistoryDay.decode(info ?? '');
    return historyDay;
  }

  static Future<void> saveMonthHistory(List<WaterHistoryMonth> historyMonth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('monthHistory', jsonEncode(historyMonth));
  }

  static Future<List<WaterHistoryMonth>> getMonthHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? info = prefs.getString('monthHistory');
    final List<WaterHistoryMonth> historyMonth = WaterHistoryMonth.decode(info ?? '');
    return historyMonth;
  }

  static Future<String> getCurrentDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentDay') ?? 'true';
  }

  static Future setCurrentDay(String currentDay) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('currentDay', currentDay);
  }
  //
}
