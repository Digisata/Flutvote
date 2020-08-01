import 'dart:convert';

class UserModel {
  UserModel({
    this.username,
    this.email,
    this.imageUrl,
    this.displayName,
    this.deviceId,
    this.isSetupCompleted,
  });

  final String username;
  final String email;
  final String imageUrl;
  final String displayName;
  final String deviceId;
  final bool isSetupCompleted;

  UserModel copyWith({
    String username,
    String email,
    String imageUrl,
    String displayName,
    String deviceId,
    bool isSetupCompleted,
  }) =>
      UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        displayName: displayName ?? this.displayName,
        deviceId: deviceId ?? this.deviceId,
        isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        displayName: json["displayName"],
        deviceId: json["deviceId"],
        isSetupCompleted: json["isSetupCompleted"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "imageUrl": imageUrl,
        "displayName": displayName,
        "deviceId": deviceId,
        "isSetupCompleted": isSetupCompleted,
      };
}
