import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/features/go_bed/model/history_sleep.dart';
import 'package:the_better_life/utils/shared_preference.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';

class GoBedProvider extends ChangeNotifier {
  static GoBedProvider of(BuildContext context) => Provider.of<GoBedProvider>(context, listen: false);
  DateTime? pickerBedToday;
  DateTime? pickerWakeUpToday;
  List<HistorySleepModel> dataSleep = [];
  HistorySleepModel historySleepModel = HistorySleepModel();

  void setTimeBedToday(DateTime date) {
    if (pickerWakeUpToday == date) {
      SnackBarBuilder.showSnackBar(content: 'TXT_SET_TIME_ERR'.tr(), status: false);
      return;
    }
    if (pickerWakeUpToday != null) {
      if (date.isAfter(pickerWakeUpToday!)) {
        SnackBarBuilder.showSnackBar(content: 'TXT_ERR_SLEEP_BEFORE'.tr(), status: false);
        return;
      }
    }
    pickerBedToday = date;
    notifyListeners();
  }

  void getListHistory()async{
    dataSleep = await SharedPrefsService.getHistorySleep();
    print(dataSleep);
    notifyListeners();
  }

  void setTimeWakeUpToday(DateTime date) {
    if (pickerBedToday == date) {
      SnackBarBuilder.showSnackBar(content: 'TXT_SET_TIME_ERR'.tr(), status: false);
      return;
    }
    if (pickerBedToday != null) {
      if (date.isBefore(pickerBedToday!)) {
        SnackBarBuilder.showSnackBar(content: 'TXT_ERR_SLEEP_BEFORE'.tr(), status: false);
        return;
      }
    }
    pickerWakeUpToday = date;
    notifyListeners();
  }

  void saveToChart() {
    if (pickerBedToday != null && pickerWakeUpToday != null) {
      final percent = pickerWakeUpToday!.difference(pickerBedToday!);
      for (int i = 0; i < dataSleep.length; i ++) {
        if (dataSleep[i].time == DateFormat(Constants.formatDateMonth).format(pickerBedToday!)) {
          dataSleep[i].percent = (percent.inMinutes / 60) + (dataSleep[i].percent ?? 0);
          SharedPrefsService.saveHistorySleep(dataSleep);
          getListHistory();
          pickerBedToday = null;
          pickerWakeUpToday = null;
          SnackBarBuilder.showSnackBar(content: 'TXT_SAVE_SLEEP_SUCCESS'.tr(), status: true);
          notifyListeners();
          return;
        }
      }
      dataSleep.add(
        HistorySleepModel(time: DateFormat(Constants.formatDateMonth).format(pickerBedToday!), percent: (percent.inMinutes / 60)),
      );
      SharedPrefsService.saveHistorySleep(dataSleep);
      getListHistory();
      pickerBedToday = null;
      pickerWakeUpToday = null;
      SnackBarBuilder.showSnackBar(content: 'TXT_SAVE_SLEEP_SUCCESS'.tr(), status: true);
      notifyListeners();
    } else {
      SnackBarBuilder.showSnackBar(content: 'TXT_PLEASE_CHOOSE_DATE_TIME'.tr(), status: false);
    }
  }
}
