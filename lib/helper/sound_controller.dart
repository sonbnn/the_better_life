import 'dart:io';

import 'package:flutter/services.dart';
import 'package:real_volume/real_volume.dart';
import 'package:soundpool/soundpool.dart';

class SoundController {
  static Soundpool pool = Soundpool.fromOptions(options: SoundpoolOptions());

  static int drinkSound = -1;

  static RingerMode? ringerMode = RingerMode.NORMAL;

  static Future initSound() async {
    var assetSound = await rootBundle.load('assets/sounds/drink_water.wav');
    drinkSound = await pool.load(assetSound);
    try {
      if (Platform.isIOS) {
        RealVolume.onRingerModeChanged.listen((event) {
          ringerMode = event;
        });
      }
    } catch (_) {}
  }

  static void playSoundDrink() async {
    try {
      if (ringerMode == RingerMode.SILENT) {
        return;
      }
      pool.play(drinkSound);
    } catch (_) {}
  }
}
