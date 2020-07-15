import 'package:flutter/material.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  final FirebaseAuths _firebaseAuths = FirebaseAuths();

  @override
  Widget build(BuildContext context) {
    final HiveProviders _hiveProviders = Provider.of<HiveProviders>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome ${_hiveProviders.getData('userEmail')}',
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  await _firebaseAuths.signOut();
                  Navigator.pushReplacementNamed(context, '/signInRoute');
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
