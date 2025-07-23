import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'color_scheme_model.dart';

part 'theme_data_model.g.dart';

@JsonSerializable()
class ThemeDataModel {
  final ColorSchemeModel colorSchemeModel;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  ThemeDataModel({
    required this.colorSchemeModel,
    required this.name,
    this.description = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ThemeDataModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeDataModelToJson(this);

  ThemeData get lightTheme {
    return ThemeData(
      colorScheme: colorSchemeModel.lightColorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorSchemeModel.lightColorScheme.surface,
        foregroundColor: colorSchemeModel.lightColorScheme.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorSchemeModel.lightColorScheme.primary,
          foregroundColor: colorSchemeModel.lightColorScheme.onPrimary,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorSchemeModel.lightColorScheme.primary,
          foregroundColor: colorSchemeModel.lightColorScheme.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorSchemeModel.lightColorScheme.primary,
          side: BorderSide(color: colorSchemeModel.lightColorScheme.outline),
        ),
      ),
      cardTheme: CardTheme(
        color: colorSchemeModel.lightColorScheme.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: colorSchemeModel.lightColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: colorSchemeModel.lightColorScheme.primary, width: 2),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      colorScheme: colorSchemeModel.darkColorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorSchemeModel.darkColorScheme.surface,
        foregroundColor: colorSchemeModel.darkColorScheme.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorSchemeModel.darkColorScheme.primary,
          foregroundColor: colorSchemeModel.darkColorScheme.onPrimary,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorSchemeModel.darkColorScheme.primary,
          foregroundColor: colorSchemeModel.darkColorScheme.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorSchemeModel.darkColorScheme.primary,
          side: BorderSide(color: colorSchemeModel.darkColorScheme.outline),
        ),
      ),
      cardTheme: CardTheme(
        color: colorSchemeModel.darkColorScheme.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: colorSchemeModel.darkColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: colorSchemeModel.darkColorScheme.primary, width: 2),
        ),
      ),
    );
  }

  ThemeDataModel copyWith({
    ColorSchemeModel? colorSchemeModel,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ThemeDataModel(
      colorSchemeModel: colorSchemeModel ?? this.colorSchemeModel,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
