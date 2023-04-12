// import 'dart:io';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';
//
// class WorkManagerHelper{
//   static const simpleTaskKey = "onechain.game.theBetterLife.simpleTask";
//
//   void callbackDispatcher() {
//     Workmanager().executeTask((task, inputData) async {
//       switch (task) {
//         case simpleTaskKey:
//           Notification.showEvent
//           break;
//         case Workmanager.iOSBackgroundTask:
//           print("The iOS background fetch was triggered");
//           Directory? tempDir = await getTemporaryDirectory();
//           String? tempPath = tempDir.path;
//           print(
//               "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
//           break;
//       }
//
//       return Future.value(true);
//     });
//   }
// }