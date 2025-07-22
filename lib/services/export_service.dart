import 'dart:convert';
import 'package:file_saver/file_saver.dart';
import '../models/theme_data_model.dart';
import '../models/color_token.dart';
import 'color_utils.dart';

class ExportService {
  static Future<void> exportAsFlutterThemeData(ThemeDataModel themeModel) async {
    final dartCode = _generateFlutterThemeData(themeModel);
    
    try {
      await FileSaver.instance.saveAs(
        name: '${_sanitizeFileName(themeModel.name)}_theme.dart',
        bytes: utf8.encode(dartCode),
        ext: 'dart',
        mimeType: MimeType.text,
      );
    } catch (e) {
      throw Exception('Failed to export Flutter theme: $e');
    }
  }

  static Future<void> exportAsJson(ThemeDataModel themeModel) async {
    final jsonData = _generateJsonData(themeModel);
    
    try {
      await FileSaver.instance.saveAs(
        name: '${_sanitizeFileName(themeModel.name)}_theme.json',
        bytes: utf8.encode(jsonData),
        ext: 'json',
        mimeType: MimeType.json,
      );
    } catch (e) {
      throw Exception('Failed to export JSON: $e');
    }
  }

  static Future<void> exportAsCssCustomProperties(ThemeDataModel themeModel) async {
    final cssData = _generateCssCustomProperties(themeModel);
    
    try {
      await FileSaver.instance.saveAs(
        name: '${_sanitizeFileName(themeModel.name)}_theme.css',
        bytes: utf8.encode(cssData),
        ext: 'css',
        mimeType: MimeType.text,
      );
    } catch (e) {
      throw Exception('Failed to export CSS: $e');
    }
  }

  static Future<void> exportAsDesignTokens(ThemeDataModel themeModel) async {
    final designTokens = _generateDesignTokens(themeModel);
    
    try {
      await FileSaver.instance.saveAs(
        name: '${_sanitizeFileName(themeModel.name)}_design_tokens.json',
        bytes: utf8.encode(designTokens),
        ext: 'json',
        mimeType: MimeType.json,
      );
    } catch (e) {
      throw Exception('Failed to export design tokens: $e');
    }
  }

  static String _generateFlutterThemeData(ThemeDataModel themeModel) {
    final lightScheme = themeModel.colorSchemeModel.lightColorScheme;
    final darkScheme = themeModel.colorSchemeModel.darkColorScheme;
    
    return '''
// Generated Material Theme Builder - ${themeModel.name}
// Created: ${themeModel.createdAt.toIso8601String()}
// Updated: ${themeModel.updatedAt.toIso8601String()}

import 'package:flutter/material.dart';

class ${_toCamelCase(themeModel.name)}Theme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0x${lightScheme.primary.value.toRadixString(16).substring(2)}),
        onPrimary: Color(0x${lightScheme.onPrimary.value.toRadixString(16).substring(2)}),
        primaryContainer: Color(0x${lightScheme.primaryContainer.value.toRadixString(16).substring(2)}),
        onPrimaryContainer: Color(0x${lightScheme.onPrimaryContainer.value.toRadixString(16).substring(2)}),
        secondary: Color(0x${lightScheme.secondary.value.toRadixString(16).substring(2)}),
        onSecondary: Color(0x${lightScheme.onSecondary.value.toRadixString(16).substring(2)}),
        secondaryContainer: Color(0x${lightScheme.secondaryContainer.value.toRadixString(16).substring(2)}),
        onSecondaryContainer: Color(0x${lightScheme.onSecondaryContainer.value.toRadixString(16).substring(2)}),
        tertiary: Color(0x${lightScheme.tertiary.value.toRadixString(16).substring(2)}),
        onTertiary: Color(0x${lightScheme.onTertiary.value.toRadixString(16).substring(2)}),
        tertiaryContainer: Color(0x${lightScheme.tertiaryContainer.value.toRadixString(16).substring(2)}),
        onTertiaryContainer: Color(0x${lightScheme.onTertiaryContainer.value.toRadixString(16).substring(2)}),
        error: Color(0x${lightScheme.error.value.toRadixString(16).substring(2)}),
        onError: Color(0x${lightScheme.onError.value.toRadixString(16).substring(2)}),
        errorContainer: Color(0x${lightScheme.errorContainer.value.toRadixString(16).substring(2)}),
        onErrorContainer: Color(0x${lightScheme.onErrorContainer.value.toRadixString(16).substring(2)}),
        surface: Color(0x${lightScheme.surface.value.toRadixString(16).substring(2)}),
        onSurface: Color(0x${lightScheme.onSurface.value.toRadixString(16).substring(2)}),
        surfaceVariant: Color(0x${lightScheme.surfaceVariant.value.toRadixString(16).substring(2)}),
        onSurfaceVariant: Color(0x${lightScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}),
        outline: Color(0x${lightScheme.outline.value.toRadixString(16).substring(2)}),
        outlineVariant: Color(0x${lightScheme.outlineVariant.value.toRadixString(16).substring(2)}),
        shadow: Color(0x${lightScheme.shadow.value.toRadixString(16).substring(2)}),
        scrim: Color(0x${lightScheme.scrim.value.toRadixString(16).substring(2)}),
        inverseSurface: Color(0x${lightScheme.inverseSurface.value.toRadixString(16).substring(2)}),
        onInverseSurface: Color(0x${lightScheme.onInverseSurface.value.toRadixString(16).substring(2)}),
        inversePrimary: Color(0x${lightScheme.inversePrimary.value.toRadixString(16).substring(2)}),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0x${darkScheme.primary.value.toRadixString(16).substring(2)}),
        onPrimary: Color(0x${darkScheme.onPrimary.value.toRadixString(16).substring(2)}),
        primaryContainer: Color(0x${darkScheme.primaryContainer.value.toRadixString(16).substring(2)}),
        onPrimaryContainer: Color(0x${darkScheme.onPrimaryContainer.value.toRadixString(16).substring(2)}),
        secondary: Color(0x${darkScheme.secondary.value.toRadixString(16).substring(2)}),
        onSecondary: Color(0x${darkScheme.onSecondary.value.toRadixString(16).substring(2)}),
        secondaryContainer: Color(0x${darkScheme.secondaryContainer.value.toRadixString(16).substring(2)}),
        onSecondaryContainer: Color(0x${darkScheme.onSecondaryContainer.value.toRadixString(16).substring(2)}),
        tertiary: Color(0x${darkScheme.tertiary.value.toRadixString(16).substring(2)}),
        onTertiary: Color(0x${darkScheme.onTertiary.value.toRadixString(16).substring(2)}),
        tertiaryContainer: Color(0x${darkScheme.tertiaryContainer.value.toRadixString(16).substring(2)}),
        onTertiaryContainer: Color(0x${darkScheme.onTertiaryContainer.value.toRadixString(16).substring(2)}),
        error: Color(0x${darkScheme.error.value.toRadixString(16).substring(2)}),
        onError: Color(0x${darkScheme.onError.value.toRadixString(16).substring(2)}),
        errorContainer: Color(0x${darkScheme.errorContainer.value.toRadixString(16).substring(2)}),
        onErrorContainer: Color(0x${darkScheme.onErrorContainer.value.toRadixString(16).substring(2)}),
        surface: Color(0x${darkScheme.surface.value.toRadixString(16).substring(2)}),
        onSurface: Color(0x${darkScheme.onSurface.value.toRadixString(16).substring(2)}),
        surfaceVariant: Color(0x${darkScheme.surfaceVariant.value.toRadixString(16).substring(2)}),
        onSurfaceVariant: Color(0x${darkScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}),
        outline: Color(0x${darkScheme.outline.value.toRadixString(16).substring(2)}),
        outlineVariant: Color(0x${darkScheme.outlineVariant.value.toRadixString(16).substring(2)}),
        shadow: Color(0x${darkScheme.shadow.value.toRadixString(16).substring(2)}),
        scrim: Color(0x${darkScheme.scrim.value.toRadixString(16).substring(2)}),
        inverseSurface: Color(0x${darkScheme.inverseSurface.value.toRadixString(16).substring(2)}),
        onInverseSurface: Color(0x${darkScheme.onInverseSurface.value.toRadixString(16).substring(2)}),
        inversePrimary: Color(0x${darkScheme.inversePrimary.value.toRadixString(16).substring(2)}),
      ),
      useMaterial3: true,
    );
  }
}
''';
  }

  static String _generateJsonData(ThemeDataModel themeModel) {
    final data = {
      'name': themeModel.name,
      'description': themeModel.description,
      'createdAt': themeModel.createdAt.toIso8601String(),
      'updatedAt': themeModel.updatedAt.toIso8601String(),
      'seeds': {
        'primary': ColorUtils.colorToHex(themeModel.colorSchemeModel.primarySeed),
        'secondary': ColorUtils.colorToHex(themeModel.colorSchemeModel.secondarySeed),
        'tertiary': ColorUtils.colorToHex(themeModel.colorSchemeModel.tertiarySeed),
        'neutral': ColorUtils.colorToHex(themeModel.colorSchemeModel.neutralSeed),
      },
      'light': _tokenMapToJson(themeModel.colorSchemeModel.lightTokens),
      'dark': _tokenMapToJson(themeModel.colorSchemeModel.darkTokens),
    };
    
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }

  static String _generateCssCustomProperties(ThemeDataModel themeModel) {
    final buffer = StringBuffer();
    buffer.writeln('/* Generated Material Theme Builder - ${themeModel.name} */');
    buffer.writeln('/* Created: ${themeModel.createdAt.toIso8601String()} */');
    buffer.writeln('/* Updated: ${themeModel.updatedAt.toIso8601String()} */');
    buffer.writeln();
    
    buffer.writeln(':root {');
    buffer.writeln('  /* Light theme */');
    themeModel.colorSchemeModel.lightTokens.forEach((name, token) {
      final hex = ColorUtils.colorToHex(token.effectiveValue);
      buffer.writeln('  --md-sys-color-$name: $hex;');
    });
    buffer.writeln('}');
    buffer.writeln();
    
    buffer.writeln('@media (prefers-color-scheme: dark) {');
    buffer.writeln('  :root {');
    buffer.writeln('    /* Dark theme */');
    themeModel.colorSchemeModel.darkTokens.forEach((name, token) {
      final hex = ColorUtils.colorToHex(token.effectiveValue);
      buffer.writeln('    --md-sys-color-$name: $hex;');
    });
    buffer.writeln('  }');
    buffer.writeln('}');
    
    return buffer.toString();
  }

  static String _generateDesignTokens(ThemeDataModel themeModel) {
    final tokens = {
      'name': themeModel.name,
      'description': themeModel.description,
      'version': '1.0.0',
      'author': 'Material Theme Builder',
      'createdAt': themeModel.createdAt.toIso8601String(),
      'updatedAt': themeModel.updatedAt.toIso8601String(),
      'global': {
        'type': 'color',
        'category': 'base',
      },
      'color': {
        'light': _generateDesignTokensForMode(themeModel.colorSchemeModel.lightTokens),
        'dark': _generateDesignTokensForMode(themeModel.colorSchemeModel.darkTokens),
      }
    };
    
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(tokens);
  }

  static Map<String, dynamic> _generateDesignTokensForMode(Map<String, ColorToken> tokens) {
    final result = <String, dynamic>{};
    
    tokens.forEach((name, token) {
      result[name] = {
        'value': ColorUtils.colorToHex(token.effectiveValue),
        'type': 'color',
        'description': token.description,
        'isCustomized': token.isCustomized,
      };
    });
    
    return result;
  }

  static Map<String, dynamic> _tokenMapToJson(Map<String, ColorToken> tokens) {
    final result = <String, dynamic>{};
    
    tokens.forEach((name, token) {
      result[name] = {
        'hex': ColorUtils.colorToHex(token.effectiveValue),
        'argb': token.effectiveValue.value,
        'isCustomized': token.isCustomized,
        'description': token.description,
      };
    });
    
    return result;
  }

  static String _sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_').toLowerCase();
  }

  static String _toCamelCase(String name) {
    final words = name.split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return 'Theme';
    
    final result = words.first.toLowerCase() +
        words.skip(1).map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase()).join('');
    
    return result.isEmpty ? 'Theme' : result[0].toUpperCase() + result.substring(1);
  }
}