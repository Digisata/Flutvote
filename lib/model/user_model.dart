import 'dart:convert';

class UserModel {
  UserModel({
    this.username,
    this.email,
    this.displayName,
    this.deviceId,
  });

  final String username;
  final String email;
  final String displayName;
  final String deviceId;

  UserModel copyWith({
    String username,
    String email,
    String displayName,
    String deviceId,
  }) =>
      UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        deviceId: deviceId ?? this.deviceId,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        displayName: json["displayName"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "displayName": displayName,
        "deviceId": deviceId,
      };
}
