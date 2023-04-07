import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/page/page_provider.dart';
import 'package:the_better_life/providers/common/connectivity_provider.dart';
import 'package:the_better_life/providers/common/theme_provider.dart';
import 'package:the_better_life/services/locator.dart';
import 'package:the_better_life/utils/secure_storage_service.dart';
import 'package:the_better_life/utils/shared_preference.dart';
import 'configs/env_config.dart';
import 'configs/router/router.dart';
import 'configs/router/routing_name.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        bool _isFirst = await SharedPrefsService.getFirstTime();
        if (_isFirst) {
          await injector.get<SecureStorage>().deleteAllSecure();
          SharedPrefsService.setFirstTime();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, manager, child) {
        return GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: MaterialApp(
            title: 'My App',
            routes: RoutesConstants.routes,
            initialRoute: RoutingNameConstants.SplashScreen,
            navigatorKey: injector.get<NavigationService>().navigatorKey,
            theme: manager.themeData,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            // localizationsDelegates: [const I18nLocalizationsDelegate()],
          ),
        );
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  EnvConfig.setEnvironment(Environment.DEV);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        //water
        ChangeNotifierProvider(create: (context) => DrinkProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path: "assets/jsons/translations",
        fallbackLocale: const Locale('en'),
        // startLocale: Locale(Platform.localeName.split('_')[0]),
        startLocale: const Locale('en'),
        child: MyApp(),
      ),
    ),
  );
}
