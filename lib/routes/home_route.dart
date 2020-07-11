import 'package:flutter/material.dart';
import 'package:flutvote/services/services.dart';

class HomeRoute extends StatelessWidget {
  final FirebaseAuths _firebaseAuths = FirebaseAuths();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome',
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  await _firebaseAuths.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                } catch (error) {
                  throw 'Sign out error: $error';
                }
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
