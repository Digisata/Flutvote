import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(
    ChangeNotifierProvider<AppProviders>(
      create: (context) => AppProviders(),
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
        '/homeRoute': (context) => HomeRoute(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: ColorPalettes.darkGrey,
            fontSize: 25.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: ColorPalettes.grey,
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
          ),
          headline3: TextStyle(
            color: ColorPalettes.white,
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: ColorPalettes.black,
            fontSize: 25.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
