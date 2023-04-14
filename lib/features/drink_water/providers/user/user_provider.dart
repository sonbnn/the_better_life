import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_water.dart';
import 'package:the_better_life/features/bmi_caculator/model/history_bmi.dart';
import 'package:the_better_life/features/drink_water/model/user.dart';
import 'package:the_better_life/helper/notification.dart';
import 'package:the_better_life/utils/shared_preference.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';

class UserProvider extends ChangeNotifier {
  User user = User();
  TextEditingController controllerInputWeight = TextEditingController();

  static UserProvider of(BuildContext context) => Provider.of<UserProvider>(context, listen: false);
  double bmi = 0;
  List<BMIHistory> bmiHistory = [];
  List bmiResult = [];

  void setWeight(double value) {
    user.weight = value;
    notifyListeners();
  }

  void setGender(String genderSelect) {
    user.gender = genderSelect;
    notifyListeners();
  }

  void setTimeWakeUp(String newTime) {
    user.wakeUpTime = newTime;
    notifyListeners();
  }

  void setTimeSleep(String newTime) {
    user.bedTime = newTime;
    notifyListeners();
  }

  void setAge(double age) {
    user.age = age;
    notifyListeners();
  }

  void setHeight(double height) {
    user.height = height;
    notifyListeners();
  }

  void plusAge(int number) {
    user.age ??= 20;
    if (user.age! <= 1 && number == -1) {
      SnackBarBuilder.showSnackBar(content: "TXT_ERR_MINUS".tr(), status: false);
      return;
    }
    setAge(user.age! + number);
  }

  void plusHeight(int number) {
    user.height ??= 150;
    if (user.height! <= 1 && number == -1) {
      SnackBarBuilder.showSnackBar(content: "TXT_ERR_MINUS".tr(), status: false);
      return;
    }
    setHeight(user.height! + number);
  }

  void saveUserInfo() async {
    await SharedPrefsService.saveUserInfo(
      User.fromJson(
        {
          "gender": user.gender,
          "weight": user.weight,
          "wakeUpTime": user.wakeUpTime,
          "bedTime": user.bedTime,
          "age": user.age,
          "recommendedMilli": user.recommendedMilli,
          "height": user.height
        },
      ),
    );
    getUserInfoData();
    notifyListeners();
  }

  void setWaterQuantity() {
    user.recommendedMilli = double.parse((((user.weight ?? 0) * 0.03) * 1000).toStringAsFixed(0));
    notifyListeners();
  }

  void getUserInfoData() async {
    user = await SharedPrefsService.getUserInfo();
    if (user.recommendedMilli != null) {
      ConstantWater.recommendedMilli = user.recommendedMilli ?? 0;
    }
    notifyListeners();
  }

  void getBMI() {
    bmi = user.weight! / pow(user.height! / 100, 2);
    notifyListeners();
  }

  void saveBMI(BMIHistory bmiResult) {
    bmiHistory.insert(0, bmiResult);
    SharedPrefsService.saveHistoryBMI(bmiHistory);
    getHistoryBMI();
  }

  void getHistoryBMI() async {
    bmiHistory = await SharedPrefsService.getHistoryBMI();
    notifyListeners();
  }

  void deleteHistoryBMI(int index) {
    bmiHistory.removeAt(index);
    SharedPrefsService.saveHistoryBMI(bmiHistory);
    getHistoryBMI();
    SnackBarBuilder.showSnackBar(content: "TXT_DELETE_SUCCESSFUL".tr());
  }

  void setNotification(DateTime dateNow) async {
    NotificationService notificationService = NotificationService();
    int timeSleepCal = int.parse(user.bedTime?.split(':').first ?? '');
    int timeSleepMini = int.parse(user.bedTime?.split(':').last ?? '');
    int timeWakeUpCal = int.parse(user.wakeUpTime?.split(':').first ?? '');

    for (int i = timeWakeUpCal + 1; i < timeSleepCal; i++) {
      await notificationService.showScheduledNotification(
        id: i,
        title: "TXT_NOTIFY_WATER_TITLE".tr(),
        body: "TXT_NOTIFY_WATER_DES".tr(),
        hour: i,
        minutes: 0,
      );
    }
    notificationService.showScheduledNotification(
      id: 0000100000110,
      title: "TXT_NOTIFY_SLEEP".tr(),
      body: "TXT_NOTIFY_SLEEP_DES".tr(),
      hour: timeSleepMini == 0 ? ((timeSleepCal == 0) ? 23 : (timeSleepCal - 1)) : timeSleepCal,
      minutes: timeSleepMini == 0 ? 45 : timeSleepMini - 15,
    );
  }

  Future<void> initBMI() async {
    final String response = await rootBundle.loadString('assets/jsons/bmi_result.json');
    final data = await json.decode(response);
    bmiResult = data['bmi_result'];
    notifyListeners();
  }
}
