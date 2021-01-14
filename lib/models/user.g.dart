// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..msg = json['msg'] as String
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'msg': instance.msg, 'data': instance.data};
