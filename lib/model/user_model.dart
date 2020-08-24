import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    @required this.deviceId,
    @required this.displayName,
    @required this.email,
    @required this.is2FAConfigured,
    @required this.isFingerprintConfigured,
    @required this.isPinConfigured,
    @required this.isSetupCompleted,
    this.lastLaunch,
    this.lastPasswordModified,
    this.lastProfileModified,
    @required this.lastSignedIn,
    @required this.photoUrl,
    @required this.username,
  });

  final String deviceId;
  final String displayName;
  final String email;
  final bool is2FAConfigured;
  final bool isFingerprintConfigured;
  final bool isPinConfigured;
  final bool isSetupCompleted;
  final Timestamp lastLaunch;
  final Timestamp lastPasswordModified;
  final Timestamp lastProfileModified;
  final Timestamp lastSignedIn;
  final String photoUrl;
  final String username;

  UserModel copyWith({
    String deviceId,
    String displayName,
    String email,
    bool is2FAConfigured,
    bool isFingerprintConfigured,
    bool isPinConfigured,
    bool isSetupCompleted,
    Timestamp lastLaunch,
    Timestamp lastPasswordModified,
    Timestamp lastProfileModified,
    Timestamp lastSignedIn,
    String photoUrl,
    String username,
  }) =>
      UserModel(
        deviceId: deviceId ?? this.deviceId,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        is2FAConfigured: is2FAConfigured ?? this.is2FAConfigured,
        isFingerprintConfigured:
            isFingerprintConfigured ?? this.isFingerprintConfigured,
        isPinConfigured: isPinConfigured ?? this.isPinConfigured,
        isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
        lastLaunch: lastLaunch ?? this.lastLaunch,
        lastPasswordModified: lastPasswordModified ?? this.lastPasswordModified,
        lastProfileModified: lastProfileModified ?? this.lastProfileModified,
        lastSignedIn: lastSignedIn ?? this.lastSignedIn,
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        deviceId: json["deviceId"],
        displayName: json["displayName"],
        email: json["email"],
        is2FAConfigured: json["is2FAConfigured"],
        isFingerprintConfigured: json["isFingerprintConfigured"],
        isPinConfigured: json["isPinConfigured"],
        isSetupCompleted: json["isSetupCompleted"],
        lastLaunch: json["lastLaunch"],
        lastPasswordModified: json["lastPasswordModified"],
        lastProfileModified: json["lastProfileModified"],
        lastSignedIn: json["lastSignedIn"],
        photoUrl: json["photoUrl"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "deviceId": deviceId,
        "displayName": displayName,
        "email": email,
        "is2FAConfigured": is2FAConfigured,
        "isFingerprintConfigured": isFingerprintConfigured,
        "isPinConfigured": isPinConfigured,
        "isSetupCompleted": isSetupCompleted,
        "lastLaunch": lastLaunch,
        "lastPasswordModified": lastPasswordModified,
        "lastProfileModified": lastProfileModified,
        "lastSignedIn": lastSignedIn,
        "photoUrl": photoUrl,
        "username": username,
      };
}
