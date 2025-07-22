import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorUtils {
  static double calculateContrast(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    
    final brightest = math.max(luminance1, luminance2);
    final darkest = math.min(luminance1, luminance2);
    
    return (brightest + 0.05) / (darkest + 0.05);
  }

  static bool meetsWCAGAA(Color foreground, Color background) {
    return calculateContrast(foreground, background) >= 4.5;
  }

  static bool meetsWCAGAAA(Color foreground, Color background) {
    return calculateContrast(foreground, background) >= 7.0;
  }

  static Color getContrastingColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  static Color lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightness = math.min(1.0, hsl.lightness + amount);
    return hsl.withLightness(lightness).toColor();
  }

  static Color darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightness = math.max(0.0, hsl.lightness - amount);
    return hsl.withLightness(lightness).toColor();
  }

  static Color adjustOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  static Map<String, double> colorToHSL(Color color) {
    final hsl = HSLColor.fromColor(color);
    return {
      'hue': hsl.hue,
      'saturation': hsl.saturation,
      'lightness': hsl.lightness,
    };
  }

  static Color hslToColor(double hue, double saturation, double lightness) {
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  static List<Color> generateHarmonicColors(Color baseColor, int count) {
    final hsl = HSLColor.fromColor(baseColor);
    final colors = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final hue = (hsl.hue + (360 / count * i)) % 360;
      final harmonicColor = HSLColor.fromAHSL(
        1.0,
        hue,
        hsl.saturation,
        hsl.lightness,
      ).toColor();
      colors.add(harmonicColor);
    }
    
    return colors;
  }

  static List<Color> generateMonochromaticColors(Color baseColor, int count) {
    final hsl = HSLColor.fromColor(baseColor);
    final colors = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final lightness = math.max(0.1, math.min(0.9, hsl.lightness + ((i - count / 2) * 0.15)));
      final monochromaticColor = HSLColor.fromAHSL(
        1.0,
        hsl.hue,
        hsl.saturation,
        lightness,
      ).toColor();
      colors.add(monochromaticColor);
    }
    
    return colors;
  }
}