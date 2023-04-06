import 'dart:math';

import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:the_better_life/configs/constants.dart';

abstract class UtilService {
  static bool checkNeedAuthentication(String url) {
    for (var value in Constants.listUrlWithoutAuthentication) {
      if (url.contains(value)) {
        return false;
      }
    }
    return true;
  }

  static Future<String> getId() async {
    try {
      String deviceId = await PlatformDeviceId.getDeviceId ?? '';
      return deviceId;
    } catch (e) {
      return '';
    }
  }

  static String getOverflowString(String? rawString) {
    if (rawString == null) return '';
    return rawString.replaceAll("", "\u{200B}");
  }

  static DateFormat getDateFormat(String date) {
    try {
      if (date.indexOf('-') == 2) {
        return DateFormat('dd-MM-yyyy');
      }
      if (date.indexOf('-') == 4) {
        return DateFormat('yyyy-MM-dd');
      }
      if (date.indexOf('/') == 2) {
        return DateFormat('dd/MM/yyyy');
      }
      if (date.indexOf('/') == 4) {
        return DateFormat('yyyy/MM/dd');
      }
      return DateFormat('dd.MM.yyyy');
    } catch (e) {
      print(e);
      return DateFormat('dd.MM.yyyy');
    }
  }

  static String getStringLineDownControl(String trans) {
    return trans.replaceAll('\\n', '\n');
  }

  static num roundDown(dynamic value, int precision) {
    try {
      // check case decimals < precision
      var parts = value.toString().split('.');
      if (parts.length > 1) {
        if (parts[1].length <= precision) {
          return num.parse(value.toString());
        }
      }
      // case default
      value = num.parse(value.toString());
      final isNegative = value.isNegative;
      final mod = pow(10.0, precision);
      final roundDown = (((value.abs() * mod).floor()) / mod);
      return isNegative ? -roundDown : roundDown;
    } catch (e, t) {
      print(t);
      return 0;
    }
  }

  static String formatNumber(num? number, {String? pattern, int? precision = 2}) {
    number ??= 0;
    pattern ??= "#,##0.00####";
    if (precision != null) number = roundDown(number, precision);
    NumberFormat oCcy = new NumberFormat(pattern, 'en_US');
    return oCcy.format(number);
  }

  static dynamic numberWithCommas(dynamic x) {
    try {
      if (x == null) return '--';
      var parts = x.toString().split('.');
      if (parts.length > 1) {
        int _end = parts[1].length - 1;
        for (int i = _end; i > 1; --i) {
          if (parts[1][i] == '0') {
            _end = i;
            continue;
          }
          break;
        }
        if (_end != parts[1].length - 1) {
          parts[1] = parts[1].substring(0, _end);
        }
      }
      parts[0] = formatNumber(num.parse(parts[0]), pattern: "#,##0", precision: null);
      return parts.join('.');
    } catch (e) {
      return '--';
    }
  }
}
