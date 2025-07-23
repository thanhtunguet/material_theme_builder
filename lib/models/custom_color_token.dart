import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../services/color_utils.dart';

part 'custom_color_token.g.dart';

@JsonSerializable()
class CustomColorToken {
  final String id;
  final String name;
  final String description;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color lightValue;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color darkValue;
  final bool isPredefined;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomColorToken({
    required this.id,
    required this.name,
    required this.description,
    required this.lightValue,
    required this.darkValue,
    this.isPredefined = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory CustomColorToken.fromJson(Map<String, dynamic> json) =>
      _$CustomColorTokenFromJson(json);

  Map<String, dynamic> toJson() => _$CustomColorTokenToJson(this);

  static Color _colorFromJson(int value) => Color(value);
  static int _colorToJson(Color color) => ColorUtils.colorToInt(color);

  String get dartVariableName {
    return name
        .replaceAll(RegExp(r'[^\w]'), '')
        .split(RegExp(r'(?=[A-Z])'))
        .map((word) => word.toLowerCase())
        .join('_')
        .replaceAll(RegExp(r'^_+|_+$'), '')
        .replaceAll(RegExp(r'_+'), '_');
  }

  CustomColorToken copyWith({
    String? id,
    String? name,
    String? description,
    Color? lightValue,
    Color? darkValue,
    bool? isPredefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomColorToken(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lightValue: lightValue ?? this.lightValue,
      darkValue: darkValue ?? this.darkValue,
      isPredefined: isPredefined ?? this.isPredefined,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}