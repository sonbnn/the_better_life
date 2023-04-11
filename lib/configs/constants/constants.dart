
import 'package:the_better_life/configs/env_config.dart';

abstract class Constants {
  static String appVersion = '1.0.0';

  static String bundleId = 'game.onechain.saas';

  static String appStoreId = '';

  static int refreshIters = 0;

  static String apiUrl = EnvConfig.apiUrl;
  
  static bool activeLogin = false;

  static bool isShowingDialog = false;

  static String successText = 'success';

  // Date Format

  static String formatDate = 'dd/MM/yyyy';

  static String formatDateMonth = 'dd/MM';

  static String formatDateTime = 'dd/MM/yyyy HH:mm:ss';

  static String formatDateHour = 'HH:mm MM/dd/yyyy';

  static String formatHourDate = 'MM/dd/yyyy HH:mm';

  static String formatHour = 'HH:mm';

  static String formatDateHourNoYear = 'HH:mm. MM/dd';


  // Local Authentication
  static String touchID = 'TOUCH_ID';

  static String faceID = 'FACE_ID';

  // Without Authentication
  static final List<String> listUrlWithoutAuthentication = [
    '.json',
  ];
}
