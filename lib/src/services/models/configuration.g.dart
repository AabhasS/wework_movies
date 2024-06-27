// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
      changeKeys: (json['change_keys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'images': instance.images,
      'change_keys': instance.changeKeys,
    };
