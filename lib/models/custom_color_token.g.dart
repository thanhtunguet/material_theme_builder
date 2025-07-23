// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_color_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomColorToken _$CustomColorTokenFromJson(Map<String, dynamic> json) =>
    CustomColorToken(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      lightValue:
          CustomColorToken._colorFromJson((json['lightValue'] as num).toInt()),
      darkValue:
          CustomColorToken._colorFromJson((json['darkValue'] as num).toInt()),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CustomColorTokenToJson(CustomColorToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'lightValue': CustomColorToken._colorToJson(instance.lightValue),
      'darkValue': CustomColorToken._colorToJson(instance.darkValue),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
