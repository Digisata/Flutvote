import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class MyVotedProviders with ChangeNotifier {
  static final Box _userData = Hive.box('userData');
  Stream<QuerySnapshot> _myVotedSnapshots = Firestore.instance
      .collection('users')
      .document(_userData.get('uid'))
      .collection('voted')
      .orderBy('timeCreated', descending: true)
      .snapshots();

  Stream<QuerySnapshot> get myVotedSnapshots => _myVotedSnapshots;
}
