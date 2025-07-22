// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeDataModel _$ThemeDataModelFromJson(Map<String, dynamic> json) =>
    ThemeDataModel(
      colorSchemeModel: ColorSchemeModel.fromJson(
          json['colorSchemeModel'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ThemeDataModelToJson(ThemeDataModel instance) =>
    <String, dynamic>{
      'colorSchemeModel': instance.colorSchemeModel,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
