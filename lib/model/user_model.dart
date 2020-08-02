import 'dart:convert';

class UserModel {
  UserModel({
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.deviceId,
    this.isSetupCompleted,
  });

  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String deviceId;
  final bool isSetupCompleted;

  UserModel copyWith({
    String username,
    String email,
    String photoUrl,
    String displayName,
    String deviceId,
    bool isSetupCompleted,
  }) =>
      UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        displayName: displayName ?? this.displayName,
        deviceId: deviceId ?? this.deviceId,
        isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        displayName: json["displayName"],
        deviceId: json["deviceId"],
        isSetupCompleted: json["isSetupCompleted"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "photoUrl": photoUrl,
        "displayName": displayName,
        "deviceId": deviceId,
        "isSetupCompleted": isSetupCompleted,
      };
}
