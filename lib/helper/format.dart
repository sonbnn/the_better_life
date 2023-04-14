import 'package:intl/intl.dart';
import 'package:the_better_life/configs/constants/constants.dart';

class Format{
  static String formatHour(DateTime? dateTime){
    if(dateTime == null){
      return '';
    }else{
      return DateFormat(Constants.formatHour).format(dateTime);
    }
  }
}