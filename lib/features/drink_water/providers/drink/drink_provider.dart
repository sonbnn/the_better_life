import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_water.dart';
import 'package:the_better_life/features/drink_water/model/watter_history.dart';
import 'package:the_better_life/utils/shared_preference.dart';

class DrinkProvider extends ChangeNotifier {
  //to day
  double amountDrinkToday = 0;
  double amount = 250;
  List<WaterHistoryDay> listHistoryDay = [];
  List<WaterHistoryMonth> listHistoryMonth = [];
  String currentDay = '';

  //page
  int currentIndexPage = 0;
  int currentQuestPage = 0;
  bool isHideBottomNavbar = false;

  double progress = 0;

  static DrinkProvider of(BuildContext context) => Provider.of<DrinkProvider>(context, listen: false);

  void setCurrentIndexPage(int index) {
    currentIndexPage = index;
    notifyListeners();
  }

  void setCurrentQuestPage(int index) {
    currentQuestPage = index;
    notifyListeners();
  }

  void setBottomNavbar(bool isHideNavbar) {
    isHideBottomNavbar = isHideNavbar;
    notifyListeners();
  }

  void setAmount(double value) {
    amount = value;
    notifyListeners();
  }

  void addWater() {
    amountDrinkToday += amount;
    progress = (amountDrinkToday / ConstantWater.recommendedMilli >= 1)
        ? 1.0
        : amountDrinkToday / ConstantWater.recommendedMilli;
    SharedPrefsService.setAmountDrinkToday(amountDrinkToday);
    notifyListeners();
  }

  void addHistoryDay({required String timeRef, required double amount}) async {
    listHistoryDay.insert(0, WaterHistoryDay(time: timeRef, amount: amount));
    if(listHistoryDay.length >= 30){
      listHistoryDay.removeLast();
    }
    SharedPrefsService.saveDayHistory(listHistoryDay);
    getHistoryDay();
    notifyListeners();
  }

  void getCurrentWaterDate() async {
    amountDrinkToday = await SharedPrefsService.getAmountDrinkToday();
    progress = (amountDrinkToday / ConstantWater.recommendedMilli >= 1)
        ? 1.0
        : amountDrinkToday / ConstantWater.recommendedMilli;
    notifyListeners();
  }

  void getHistoryDay() async {
    listHistoryDay = await SharedPrefsService.getDayHistory();
    notifyListeners();
  }

  void getHistoryMonth() async {
    listHistoryMonth = await SharedPrefsService.getMonthHistory();
    notifyListeners();
  }

  void getCurrentDay() async {
    currentDay = await SharedPrefsService.getCurrentDay();
    notifyListeners();
  }

  void setCurrentDay() {
    SharedPrefsService.setCurrentDay(ConstantWater.dateNow);
    getCurrentDay();
    notifyListeners();
  }

  void checkDay() async {
    String currentDay = await SharedPrefsService.getCurrentDay();
    if (ConstantWater.dateNow != currentDay) {
      listHistoryMonth.insert(
        0,
        WaterHistoryMonth(
          result: '${amountDrinkToday.toStringAsFixed(0)} / ${ConstantWater.recommendedMilli.toStringAsFixed(0)}',
          date: currentDay,
        ),
      );
      SharedPrefsService.saveMonthHistory(listHistoryMonth);
      setCurrentDay();

      //reset data
      resetDataDay();
    }
  }

  void initProvider() {
    getCurrentWaterDate();
    getHistoryDay();
    getHistoryMonth();
    getCurrentDay();
  }

  void resetDataDay() async {
    SharedPrefsService.setAmountDrinkToday(0);
    amountDrinkToday = await SharedPrefsService.getAmountDrinkToday();
    setCurrentDay();
    SharedPrefsService.saveDayHistory([]);
    getHistoryDay();
    notifyListeners();
  }
}
