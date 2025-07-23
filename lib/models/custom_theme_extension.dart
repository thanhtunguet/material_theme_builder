import 'package:flutter/material.dart';
import 'custom_color_token.dart';
import '../services/color_utils.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Map<String, Color> customColors;

  const CustomThemeExtension({
    required this.customColors,
  });

  factory CustomThemeExtension.fromTokens(List<CustomColorToken> tokens, Brightness brightness) {
    final Map<String, Color> colors = {};
    
    for (final token in tokens) {
      colors[token.dartVariableName] = brightness == Brightness.light 
          ? token.lightValue 
          : token.darkValue;
    }
    
    return CustomThemeExtension(customColors: colors);
  }

  Color? color(String name) => customColors[name];

  @override
  CustomThemeExtension copyWith({
    Map<String, Color>? customColors,
  }) {
    return CustomThemeExtension(
      customColors: customColors ?? this.customColors,
    );
  }

  @override
  CustomThemeExtension lerp(ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }

    final Map<String, Color> lerpedColors = {};
    final allKeys = {...customColors.keys, ...other.customColors.keys};

    for (final key in allKeys) {
      final thisColor = customColors[key] ?? Colors.transparent;
      final otherColor = other.customColors[key] ?? Colors.transparent;
      lerpedColors[key] = Color.lerp(thisColor, otherColor, t) ?? thisColor;
    }

    return CustomThemeExtension(customColors: lerpedColors);
  }

  String generateDartCode(String className, List<CustomColorToken> tokens) {
    final buffer = StringBuffer();
    
    buffer.writeln('class $className extends ThemeExtension<$className> {');
    
    for (final token in tokens) {
      buffer.writeln('  final Color ${token.dartVariableName};');
    }
    
    buffer.writeln();
    buffer.writeln('  const $className({');
    for (final token in tokens) {
      buffer.writeln('    required this.${token.dartVariableName},');
    }
    buffer.writeln('  });');
    
    buffer.writeln();
    buffer.writeln('  static $className light = const $className(');
    for (final token in tokens) {
      final hex = ColorUtils.colorToInt(token.lightValue).toRadixString(16).substring(2);
      buffer.writeln('    ${token.dartVariableName}: Color(0xFF$hex),');
    }
    buffer.writeln('  );');
    
    buffer.writeln();
    buffer.writeln('  static $className dark = const $className(');
    for (final token in tokens) {
      final hex = ColorUtils.colorToInt(token.darkValue).toRadixString(16).substring(2);
      buffer.writeln('    ${token.dartVariableName}: Color(0xFF$hex),');
    }
    buffer.writeln('  );');
    
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  $className copyWith({');
    for (final token in tokens) {
      buffer.writeln('    Color? ${token.dartVariableName},');
    }
    buffer.writeln('  }) {');
    buffer.writeln('    return $className(');
    for (final token in tokens) {
      buffer.writeln('      ${token.dartVariableName}: ${token.dartVariableName} ?? this.${token.dartVariableName},');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  $className lerp(ThemeExtension<$className>? other, double t) {');
    buffer.writeln('    if (other is! $className) {');
    buffer.writeln('      return this;');
    buffer.writeln('    }');
    buffer.writeln('    return $className(');
    for (final token in tokens) {
      buffer.writeln('      ${token.dartVariableName}: Color.lerp(${token.dartVariableName}, other.${token.dartVariableName}, t)!,');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    
    buffer.writeln('}');
    
    return buffer.toString();
  }
}