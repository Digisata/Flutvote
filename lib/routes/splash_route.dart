import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/firebase_service.dart';

class SplashRoute extends StatefulWidget {
  @override
  _SplashRouteState createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  final FirebaseService _firebaseService = FirebaseService();

  _navigateTo() async {
    if (await _firebaseService.getCurrentUser() == null ||
        !await _firebaseService.isEmailVerified()) {
      if (!HiveProviders.getFirstOpened()) {
        Navigator.pushReplacementNamed(context, '/signInRoute');
      } else {
        Navigator.pushReplacementNamed(context, '/welcomeRoute');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/homeRoute');
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ContentColors.white,
        ),
      ),
    );
  }
}
