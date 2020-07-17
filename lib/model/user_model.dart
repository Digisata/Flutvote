class UserModel {
  final String username;
  final String email;
  final String displayName;

  UserModel(
    this.username,
    this.email,
    this.displayName,
  );

  UserModel.fromData(Map<String, dynamic> data)
      : username = data['username'],
        email = data['email'],
        displayName = data['displayName'];

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'displayName': displayName,
    };
  }
}
