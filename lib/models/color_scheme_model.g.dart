// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_scheme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorSchemeModel _$ColorSchemeModelFromJson(Map<String, dynamic> json) =>
    ColorSchemeModel(
      primarySeed:
          ColorSchemeModel._colorFromJson((json['primarySeed'] as num).toInt()),
      secondarySeed: ColorSchemeModel._colorFromJson(
          (json['secondarySeed'] as num).toInt()),
      tertiarySeed: ColorSchemeModel._colorFromJson(
          (json['tertiarySeed'] as num).toInt()),
      neutralSeed:
          ColorSchemeModel._colorFromJson((json['neutralSeed'] as num).toInt()),
      lightTokens: (json['lightTokens'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ColorToken.fromJson(e as Map<String, dynamic>)),
      ),
      darkTokens: (json['darkTokens'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ColorToken.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ColorSchemeModelToJson(ColorSchemeModel instance) =>
    <String, dynamic>{
      'primarySeed': ColorSchemeModel._colorToJson(instance.primarySeed),
      'secondarySeed': ColorSchemeModel._colorToJson(instance.secondarySeed),
      'tertiarySeed': ColorSchemeModel._colorToJson(instance.tertiarySeed),
      'neutralSeed': ColorSchemeModel._colorToJson(instance.neutralSeed),
      'lightTokens': instance.lightTokens,
      'darkTokens': instance.darkTokens,
    };
