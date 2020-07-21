import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveProviders.openBox();
  AppProviders.setAppVersion();
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProviders>(
          create: (context) => AppProviders(),
        ),
        ChangeNotifierProvider<HiveProviders>(
          create: (context) => HiveProviders(),
        ),
        ChangeNotifierProvider<SignInProviders>(
          create: (context) => SignInProviders(),
        ),
        ChangeNotifierProvider<SignUpProviders>(
          create: (context) => SignUpProviders(),
        ),
        ChangeNotifierProvider<ForgotPasswordProviders>(
          create: (context) => ForgotPasswordProviders(),
        ),
        ChangeNotifierProvider<HomeProviders>(
          create: (context) => HomeProviders(),
        ),
        ChangeNotifierProvider<EditProfileProviders>(
          create: (context) => EditProfileProviders(),
        ),
        ChangeNotifierProvider<ChangePasswordProviders>(
          create: (context) => ChangePasswordProviders(),
        ),
      ],
      child: Flutvote(),
    ),
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

class Flutvote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutvote',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashRoute(),
        '/welcomeRoute': (context) => WelcomeRoute(),
        '/signInRoute': (context) => SignInRoute(),
        '/signUpRoute': (context) => SignUpRoute(),
        '/forgotPasswordRoute': (context) => ForgotPasswordRoute(),
        '/introductionRoute': (context) => IntroductionRoute(),
        '/homeRoute': (context) => HomeRoute(),
        '/historyRoute': (context) => HistoryRoute(),
        '/settingRoute': (context) => SettingRoute(),
        '/editProfileRoute': (context) => EditProfileRoute(),
        '/changePasswordRoute': (context) => ChangePasswordRoute(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: ContentColors.darkGrey,
            fontSize: 25.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: ContentColors.grey,
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
          ),
          headline3: TextStyle(
            color: ContentColors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: ContentColors.black,
            fontSize: 25.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
