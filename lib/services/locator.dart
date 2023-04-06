// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_better_life/utils/secure_storage_service.dart';


void setupLocator() {
  const storage = FlutterSecureStorage();
  AppModules.inject();
  injector.registerLazySingleton(() => SecureStorage(storage));
}
