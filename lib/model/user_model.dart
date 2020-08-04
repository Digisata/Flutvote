import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    @required this.deviceId,
    @required this.displayName,
    @required this.email,
    @required this.isSetupCompleted,
    @required this.photoUrl,
    @required this.username,
  });

  final String deviceId;
  final String displayName;
  final String email;
  final bool isSetupCompleted;
  final String photoUrl;
  final String username;

  UserModel copyWith({
    String deviceId,
    String displayName,
    String email,
    bool isSetupCompleted,
    String photoUrl,
    String username,
  }) =>
      UserModel(
        deviceId: deviceId ?? this.deviceId,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        deviceId: json["deviceId"],
        displayName: json["displayName"],
        email: json["email"],
        isSetupCompleted: json["isSetupCompleted"],
        photoUrl: json["photoUrl"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "deviceId": deviceId,
        "displayName": displayName,
        "email": email,
        "isSetupCompleted": isSetupCompleted,
        "photoUrl": photoUrl,
        "username": username,
      };
}
