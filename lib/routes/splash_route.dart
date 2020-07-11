import 'package:flutter/material.dart';
import 'package:flutvote/services/services.dart';

class SplashRoute extends StatelessWidget {
  final FacebookAuths _facebookAuths = FacebookAuths();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () async {
            try {
              await _facebookAuths.signInWithFacebook();
              Navigator.pushReplacementNamed(context, '/homeRoute');
            } catch (error) {
              throw 'facebook sign in error: $error';
            }
          },
        ),
      ),
    );
  }
}
