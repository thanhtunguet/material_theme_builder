import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../services/color_utils.dart';

part 'color_token.g.dart';

@JsonSerializable()
class ColorToken {
  final String name;
  final String description;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color defaultValue;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color? customValue;
  final bool isCustomizable;

  ColorToken({
    required this.name,
    required this.description,
    required this.defaultValue,
    this.customValue,
    this.isCustomizable = true,
  });

  Color get effectiveValue => customValue ?? defaultValue;
  bool get isCustomized => customValue != null;

  void setCustomValue(Color? color) {
    customValue = color;
  }

  void resetToDefault() {
    customValue = null;
  }

  factory ColorToken.fromJson(Map<String, dynamic> json) =>
      _$ColorTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ColorTokenToJson(this);

  static Color _colorFromJson(int? value) {
    if (value == null) return Colors.transparent;
    return Color(value);
  }

  static int? _colorToJson(Color? color) {
    return color != null ? ColorUtils.colorToInt(color) : null;
  }

  ColorToken copyWith({
    String? name,
    String? description,
    Color? defaultValue,
    Color? customValue,
    bool? isCustomizable,
  }) {
    return ColorToken(
      name: name ?? this.name,
      description: description ?? this.description,
      defaultValue: defaultValue ?? this.defaultValue,
      customValue: customValue ?? this.customValue,
      isCustomizable: isCustomizable ?? this.isCustomizable,
    );
  }
}
