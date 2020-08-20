import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/firebase_service.dart';
import 'package:flutvote/services/services.dart';

class SplashRoute extends StatefulWidget {
  @override
  _SplashRouteState createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  final FirebaseService _firebaseService = FirebaseService();
  final FirestoreService _firestoreService = FirestoreService();

  void _navigateTo() async {
    if (await _firebaseService.getCurrentUser() == null ||
        !await _firebaseService.isEmailVerified()) {
      if (!HiveProviders.getFirstOpened()) {
        Navigator.pushReplacementNamed(context, ContentTexts.signInRoute);
      } else {
        Navigator.pushReplacementNamed(context, ContentTexts.welcomeRoute);
      }
    } else if (!HiveProviders.getIsSetupCompleted()) {
      Navigator.pushReplacementNamed(context, ContentTexts.introductionRoute);
    } else {
      await _firestoreService.fetchUserData();
      await HiveProviders.syncUserData();
      Navigator.pushReplacementNamed(context, ContentTexts.homeRoute);
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
