import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

/// flutter编码规范dart文件名统一小写
/// https://www.jianshu.com/p/b307a377c5e8
/// flutter packages pub run build_runner build

@JsonSerializable()
class User {
  User(
      this.ticket,
      this.phone,
      this.loginName,
      );
  String ticket;
  String phone;
  String loginName;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);

  //命名构造函数
  User.empty();
}