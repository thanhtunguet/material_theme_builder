// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorToken _$ColorTokenFromJson(Map<String, dynamic> json) => ColorToken(
      name: json['name'] as String,
      description: json['description'] as String,
      defaultValue:
          ColorToken._colorFromJson((json['defaultValue'] as num?)?.toInt()),
      customValue:
          ColorToken._colorFromJson((json['customValue'] as num?)?.toInt()),
      isCustomizable: json['isCustomizable'] as bool? ?? true,
    );

Map<String, dynamic> _$ColorTokenToJson(ColorToken instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'defaultValue': ColorToken._colorToJson(instance.defaultValue),
      'customValue': ColorToken._colorToJson(instance.customValue),
      'isCustomizable': instance.isCustomizable,
    };
