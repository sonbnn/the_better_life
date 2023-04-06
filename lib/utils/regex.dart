

import 'package:core/core.dart';

abstract class RegexConstant {
  static RegexConfig none = RegexConfig(pattern: r'.{0,}', errorText: 'No validate');

  static RegexConfig notEmpty = RegexConfig(pattern: r'.{1,}', errorText: 'TEXT_REGEX_NOT_EMPTY');

  static RegexConfig notEmptyChoose = RegexConfig(pattern: r'.{1,}', errorText: 'TEXT_REGEX_NOT_EMPTY_CHOOSE');

  static RegexConfig email = RegexConfig(pattern: r'^[\w-\.+]+@([\w-]+\.)+[\w-]{2,4}$', errorText: 'TEXT_REGEX_EMAIL');

  static RegexConfig password = RegexConfig(
    pattern: r'.{6,}$',
    errorText: 'TEXT_REGEX_PASSWORD',
  );
  // static RegexConfig password = RegexConfig(
  //   pattern: r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,20}$',
  //   errorText: 'TEXT_REGEX_PASSWORD',
  // );
}
