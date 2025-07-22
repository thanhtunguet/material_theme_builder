import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'color_token.dart';

part 'color_scheme_model.g.dart';

@JsonSerializable()
class ColorSchemeModel {
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color primarySeed;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color secondarySeed;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color tertiarySeed;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color neutralSeed;

  final Map<String, ColorToken> lightTokens;
  final Map<String, ColorToken> darkTokens;

  ColorSchemeModel({
    required this.primarySeed,
    required this.secondarySeed,
    required this.tertiarySeed,
    required this.neutralSeed,
    required this.lightTokens,
    required this.darkTokens,
  });

  factory ColorSchemeModel.fromJson(Map<String, dynamic> json) =>
      _$ColorSchemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColorSchemeModelToJson(this);

  static Color _colorFromJson(int value) => Color(value);
  static int _colorToJson(Color color) => color.value;

  ColorScheme get lightColorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      primary: lightTokens['primary']?.effectiveValue ?? primarySeed,
      onPrimary: lightTokens['onPrimary']?.effectiveValue ?? Colors.white,
      primaryContainer: lightTokens['primaryContainer']?.effectiveValue ?? primarySeed.withOpacity(0.2),
      onPrimaryContainer: lightTokens['onPrimaryContainer']?.effectiveValue ?? primarySeed,
      secondary: lightTokens['secondary']?.effectiveValue ?? secondarySeed,
      onSecondary: lightTokens['onSecondary']?.effectiveValue ?? Colors.white,
      secondaryContainer: lightTokens['secondaryContainer']?.effectiveValue ?? secondarySeed.withOpacity(0.2),
      onSecondaryContainer: lightTokens['onSecondaryContainer']?.effectiveValue ?? secondarySeed,
      tertiary: lightTokens['tertiary']?.effectiveValue ?? tertiarySeed,
      onTertiary: lightTokens['onTertiary']?.effectiveValue ?? Colors.white,
      tertiaryContainer: lightTokens['tertiaryContainer']?.effectiveValue ?? tertiarySeed.withOpacity(0.2),
      onTertiaryContainer: lightTokens['onTertiaryContainer']?.effectiveValue ?? tertiarySeed,
      error: lightTokens['error']?.effectiveValue ?? Colors.red,
      onError: lightTokens['onError']?.effectiveValue ?? Colors.white,
      errorContainer: lightTokens['errorContainer']?.effectiveValue ?? Colors.red.withOpacity(0.2),
      onErrorContainer: lightTokens['onErrorContainer']?.effectiveValue ?? Colors.red,
      surface: lightTokens['surface']?.effectiveValue ?? Colors.white,
      onSurface: lightTokens['onSurface']?.effectiveValue ?? Colors.black,
      surfaceVariant: lightTokens['surfaceVariant']?.effectiveValue ?? Colors.grey[100]!,
      onSurfaceVariant: lightTokens['onSurfaceVariant']?.effectiveValue ?? Colors.grey[700]!,
      outline: lightTokens['outline']?.effectiveValue ?? Colors.grey[400]!,
      outlineVariant: lightTokens['outlineVariant']?.effectiveValue ?? Colors.grey[300]!,
      shadow: lightTokens['shadow']?.effectiveValue ?? Colors.black,
      scrim: lightTokens['scrim']?.effectiveValue ?? Colors.black,
      inverseSurface: lightTokens['inverseSurface']?.effectiveValue ?? Colors.black,
      onInverseSurface: lightTokens['onInverseSurface']?.effectiveValue ?? Colors.white,
      inversePrimary: lightTokens['inversePrimary']?.effectiveValue ?? primarySeed.withOpacity(0.8),
    );
  }

  ColorScheme get darkColorScheme {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: darkTokens['primary']?.effectiveValue ?? primarySeed,
      onPrimary: darkTokens['onPrimary']?.effectiveValue ?? Colors.black,
      primaryContainer: darkTokens['primaryContainer']?.effectiveValue ?? primarySeed.withOpacity(0.3),
      onPrimaryContainer: darkTokens['onPrimaryContainer']?.effectiveValue ?? primarySeed,
      secondary: darkTokens['secondary']?.effectiveValue ?? secondarySeed,
      onSecondary: darkTokens['onSecondary']?.effectiveValue ?? Colors.black,
      secondaryContainer: darkTokens['secondaryContainer']?.effectiveValue ?? secondarySeed.withOpacity(0.3),
      onSecondaryContainer: darkTokens['onSecondaryContainer']?.effectiveValue ?? secondarySeed,
      tertiary: darkTokens['tertiary']?.effectiveValue ?? tertiarySeed,
      onTertiary: darkTokens['onTertiary']?.effectiveValue ?? Colors.black,
      tertiaryContainer: darkTokens['tertiaryContainer']?.effectiveValue ?? tertiarySeed.withOpacity(0.3),
      onTertiaryContainer: darkTokens['onTertiaryContainer']?.effectiveValue ?? tertiarySeed,
      error: darkTokens['error']?.effectiveValue ?? Colors.redAccent,
      onError: darkTokens['onError']?.effectiveValue ?? Colors.black,
      errorContainer: darkTokens['errorContainer']?.effectiveValue ?? Colors.redAccent.withOpacity(0.3),
      onErrorContainer: darkTokens['onErrorContainer']?.effectiveValue ?? Colors.redAccent,
      surface: darkTokens['surface']?.effectiveValue ?? Colors.grey[900]!,
      onSurface: darkTokens['onSurface']?.effectiveValue ?? Colors.white,
      surfaceVariant: darkTokens['surfaceVariant']?.effectiveValue ?? Colors.grey[800]!,
      onSurfaceVariant: darkTokens['onSurfaceVariant']?.effectiveValue ?? Colors.grey[300]!,
      outline: darkTokens['outline']?.effectiveValue ?? Colors.grey[600]!,
      outlineVariant: darkTokens['outlineVariant']?.effectiveValue ?? Colors.grey[700]!,
      shadow: darkTokens['shadow']?.effectiveValue ?? Colors.black,
      scrim: darkTokens['scrim']?.effectiveValue ?? Colors.black,
      inverseSurface: darkTokens['inverseSurface']?.effectiveValue ?? Colors.white,
      onInverseSurface: darkTokens['onInverseSurface']?.effectiveValue ?? Colors.black,
      inversePrimary: darkTokens['inversePrimary']?.effectiveValue ?? primarySeed.withOpacity(0.8),
    );
  }

  ColorSchemeModel copyWith({
    Color? primarySeed,
    Color? secondarySeed,
    Color? tertiarySeed,
    Color? neutralSeed,
    Map<String, ColorToken>? lightTokens,
    Map<String, ColorToken>? darkTokens,
  }) {
    return ColorSchemeModel(
      primarySeed: primarySeed ?? this.primarySeed,
      secondarySeed: secondarySeed ?? this.secondarySeed,
      tertiarySeed: tertiarySeed ?? this.tertiarySeed,
      neutralSeed: neutralSeed ?? this.neutralSeed,
      lightTokens: lightTokens ?? Map.from(this.lightTokens),
      darkTokens: darkTokens ?? Map.from(this.darkTokens),
    );
  }
}