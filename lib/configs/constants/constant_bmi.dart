import 'package:easy_localization/easy_localization.dart';

class ConstantBMI {
  static String getInterpretation(double bmi) {
    if (bmi >= 40) {
      return 'TXT_BMI_GRADE3'.tr();
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      return 'TXT_BMI_GRADE2'.tr();
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      return 'TXT_BMI_GRADE1'.tr();
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 'TXT_BMI_OVERWEIGHT'.tr();
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'TXT_BMI_NORMAL'.tr();
    } else if (bmi >= 17.0 && bmi <= 18.4) {
      return 'TXT_BMI_MILDLY_UNDERWEIGHT'.tr();
    } else if (bmi >= 16.0 && bmi <= 16.9) {
      return 'TXT_BMI_UNDERWEIGHT'.tr();
    } else {
      return "TXT_BMI_SEVERELY_UNDERWEIGHT".tr();
    }
  }

  static int getIndex(double bmi) {
    if (bmi >= 40) {
      return 7;
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      return 6;
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      return 5;
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 4;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 3;
    } else if (bmi >= 17.0 && bmi <= 18.4) {
      return 2;
    } else if (bmi >= 16.0 && bmi <= 16.9) {
      return 1;
    } else {
      return 0;
    }
  }
}
