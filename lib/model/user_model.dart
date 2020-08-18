import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    @required this.deviceId,
    @required this.displayName,
    @required this.email,
    @required this.is2FaConfigured,
    @required this.isFingerprintConfigured,
    @required this.isPinConfigured,
    @required this.isSetupCompleted,
    @required this.lastPasswordModified,
    @required this.lastProfileModified,
    @required this.photoUrl,
    @required this.username,
  });

  final String deviceId;
  final String displayName;
  final String email;
  final bool is2FaConfigured;
  final bool isFingerprintConfigured;
  final bool isPinConfigured;
  final bool isSetupCompleted;
  final Timestamp lastPasswordModified;
  final Timestamp lastProfileModified;
  final String photoUrl;
  final String username;

  UserModel copyWith({
    String deviceId,
    String displayName,
    String email,
    bool is2FaConfigured,
    bool isFingerprintConfigured,
    bool isPinConfigured,
    bool isSetupCompleted,
    Timestamp lastPasswordModified,
    Timestamp lastProfileModified,
    String photoUrl,
    String username,
  }) =>
      UserModel(
        deviceId: deviceId ?? this.deviceId,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        is2FaConfigured: is2FaConfigured ?? this.is2FaConfigured,
        isFingerprintConfigured:
            isFingerprintConfigured ?? this.isFingerprintConfigured,
        isPinConfigured: isPinConfigured ?? this.isPinConfigured,
        isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
        lastPasswordModified: lastPasswordModified ?? this.lastPasswordModified,
        lastProfileModified: lastProfileModified ?? this.lastProfileModified,
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        deviceId: json["deviceId"],
        displayName: json["displayName"],
        email: json["email"],
        is2FaConfigured: json["is2FAConfigured"],
        isFingerprintConfigured: json["isFingerprintConfigured"],
        isPinConfigured: json["isPinConfigured"],
        isSetupCompleted: json["isSetupCompleted"],
        lastPasswordModified: json["lastPasswordModified"],
        lastProfileModified: json["lastProfileModified"],
        photoUrl: json["photoUrl"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "deviceId": deviceId,
        "displayName": displayName,
        "email": email,
        "is2FAConfigured": is2FaConfigured,
        "isFingerprintConfigured": isFingerprintConfigured,
        "isPinConfigured": isPinConfigured,
        "isSetupCompleted": isSetupCompleted,
        "lastPasswordModified": lastPasswordModified,
        "lastProfileModified": lastProfileModified,
        "photoUrl": photoUrl,
        "username": username,
      };
}
