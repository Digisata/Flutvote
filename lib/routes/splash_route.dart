import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/services/firebase_auths.dart';

class SplashRoute extends StatefulWidget {
  @override
  _SplashRouteState createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  final FirebaseAuths _firebaseAuths = FirebaseAuths();

  _navigateRoute() async {
    if (await _firebaseAuths.getCurrentUser() == null) {
      Navigator.pushReplacementNamed(context, '/welcomeRoute');
    } else {
      Navigator.pushReplacementNamed(context, '/homeRoute');
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorPalettes.white,
        ),
      ),
    );
  }
}
