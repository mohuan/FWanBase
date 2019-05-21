// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(json['ticket'] as String, json['phone'] as String,
      json['loginName'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ticket': instance.ticket,
      'phone': instance.phone,
      'loginName': instance.loginName
    };
