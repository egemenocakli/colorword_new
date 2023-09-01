import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/language_manager.dart';
import 'package:colorword_new/core/navigator/app_router.dart';
import 'package:colorword_new/firebase_options.dart';
import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

Future<void> main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  initFirebaseServices();

  runApp(buildApp());
}

Future<void> initFirebaseServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

MultiProvider buildApp() {
  return MultiProvider(
    providers: providers,
    child: EasyLocalization(
        supportedLocales: (LanguageManager.instance?.supportedLocales)!,
        path: AppConstants.localizationAssetPath,
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp()),
  );
}

get providers => [
      ChangeNotifierProvider<AuthViewModel>(create: (context) => AuthViewModel()),
    ];

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: 'ColorWord',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        useMaterial3: true,
      ),
      //home: const LoginView(),
    );
  }
}
