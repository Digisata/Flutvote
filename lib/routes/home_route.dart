import 'package:flutter/material.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/services/services.dart';
import 'package:hive/hive.dart';

class HomeRoute extends StatelessWidget {
  final FirebaseAuths _firebaseAuths = FirebaseAuths();

  @override
  Widget build(BuildContext context) {
    final Box _userDatas = Hive.box('userData');
    UserData _userEmail = _userDatas.getAt(0);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome ${_userEmail.email}',
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
