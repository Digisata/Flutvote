import 'package:hive/hive.dart';
part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;

  UserData(this.email, this.password);
}
