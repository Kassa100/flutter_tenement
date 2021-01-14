// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order()
    ..msg = json['msg'] as String
    ..list = json['list'] as List;
}

Map<String, dynamic> _$OrderToJson(Order instance) =>
    <String, dynamic>{'msg': instance.msg, 'list': instance.list};
