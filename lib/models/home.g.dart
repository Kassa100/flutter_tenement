// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home()
    ..banner = json['banner'] as String
    ..banner_text = json['banner_text'] as String
    ..icons = json['icons'] as List
    ..region = json['region'] as List
    ..apart = json['apart'] as List
    ..flats = json['flats'] as List;
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'banner': instance.banner,
      'banner_text': instance.banner_text,
      'icons': instance.icons,
      'region': instance.region,
      'apart': instance.apart,
      'flats': instance.flats
    };
