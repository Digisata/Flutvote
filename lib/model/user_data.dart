import 'package:hive/hive.dart';
part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String email;
  @HiveField(2)
  String displayName;
  @HiveField(3)
  bool isFirstOpened;
  @HiveField(4)
  bool isFirstSignedIn;

  UserData({
    this.userName,
    this.email,
    this.displayName,
    this.isFirstOpened = true,
    this.isFirstSignedIn = true,
  });
}
