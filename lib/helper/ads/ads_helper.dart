import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8833648214272621/9764382481';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8833648214272621/2256840820';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8833648214272621/3401605376";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8833648214272621/9315442880";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8833648214272621/3649017383";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8833648214272621/1806001418";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8833648214272621/3198974135';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8833648214272621/5936818114';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
