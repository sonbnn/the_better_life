import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_water.dart';
import 'package:the_better_life/features/drink_water/model/user.dart';
import 'package:the_better_life/utils/shared_preference.dart';

class UserProvider extends ChangeNotifier {
  User user = User();
  TextEditingController controllerInputWeight = TextEditingController();
  static UserProvider of(BuildContext context) => Provider.of<UserProvider>(context, listen: false);
  double bmi = 0;
  void setWeight(double value) {
    user.weight = value;
    notifyListeners();
  }

  void setGender(String genderSelect) {
    user.gender = genderSelect;
    notifyListeners();
  }

  void setTimeWakeUp(TimeOfDay newTime) {
    user.wakeUpTime = '${newTime.hour}:${newTime.minute}';
    notifyListeners();
  }

  void setTimeSleep(TimeOfDay newTime) {
    user.bedTime = '${newTime.hour}:${newTime.minute}';
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
    setAge(user.age! + number);
  }

  void plusHeight(int number) {
    user.height ??= 150;
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
    notifyListeners();
  }

  void setWatterQuantity() {
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

  void getBMI(){
    bmi = user.weight! / pow(user.height!/100,2);
    notifyListeners();
  }

}
