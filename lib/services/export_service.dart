import 'dart:convert';
import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter

import '../models/color_token.dart';
import '../models/theme_data_model.dart';
import 'color_utils.dart';
import 'custom_token_service.dart';

class ExportService {
  static Future<void> exportAsFlutterThemeData(
    ThemeDataModel themeModel, {
    CustomTokenService? customTokenService,
  }) async {
    final dartCode = _generateFlutterThemeData(themeModel, customTokenService);

    try {
      _downloadFile(
        content: dartCode,
        filename: '${_sanitizeFileName(themeModel.name)}_theme.dart',
        mimeType: 'text/plain',
      );
    } catch (e) {
      throw Exception('Failed to export Flutter theme: $e');
    }
  }

  static Future<void> exportAsThemeExtension(
    CustomTokenService customTokenService, {
    String? className,
  }) async {
    final extensionCode =
        _generateThemeExtensionCode(customTokenService, className);

    try {
      _downloadFile(
        content: extensionCode,
        filename:
            '${_sanitizeFileName(className ?? 'CustomColors')}_extension.dart',
        mimeType: 'text/plain',
      );
    } catch (e) {
      throw Exception('Failed to export theme extension: $e');
    }
  }

  static Future<void> exportAsJson(ThemeDataModel themeModel) async {
    final jsonData = _generateJsonData(themeModel);

    try {
      _downloadFile(
        content: jsonData,
        filename: '${_sanitizeFileName(themeModel.name)}_theme.json',
        mimeType: 'application/json',
      );
    } catch (e) {
      throw Exception('Failed to export JSON: $e');
    }
  }

  static Future<void> exportAsCssCustomProperties(
      ThemeDataModel themeModel) async {
    final cssData = _generateCssCustomProperties(themeModel);

    try {
      _downloadFile(
        content: cssData,
        filename: '${_sanitizeFileName(themeModel.name)}_theme.css',
        mimeType: 'text/css',
      );
    } catch (e) {
      throw Exception('Failed to export CSS: $e');
    }
  }

  static Future<void> exportAsDesignTokens(ThemeDataModel themeModel) async {
    final designTokens = _generateDesignTokens(themeModel);

    try {
      _downloadFile(
        content: designTokens,
        filename: '${_sanitizeFileName(themeModel.name)}_design_tokens.json',
        mimeType: 'application/json',
      );
    } catch (e) {
      throw Exception('Failed to export design tokens: $e');
    }
  }

  static void _downloadFile({
    required String content,
    required String filename,
    required String mimeType,
  }) {
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.Url.revokeObjectUrl(url);
  }

  static String _generateFlutterThemeData(
      ThemeDataModel themeModel, CustomTokenService? customTokenService) {
    final lightScheme = themeModel.colorSchemeModel.lightColorScheme;
    final darkScheme = themeModel.colorSchemeModel.darkColorScheme;
    final hasCustomTokens = customTokenService != null &&
        customTokenService.customTokens.isNotEmpty;

    return '''
// Generated Material Theme Builder - ${themeModel.name}
// Created: ${themeModel.createdAt.toIso8601String()}
// Updated: ${themeModel.updatedAt.toIso8601String()}

import 'package:flutter/material.dart';${hasCustomTokens ? '\n\n${_generateThemeExtensionCode(customTokenService, null)}' : ''}

class ${_toCamelCase(themeModel.name)}Theme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0x${ColorUtils.colorToInt(lightScheme.primary).toRadixString(16).substring(2)}),
        onPrimary: Color(0x${ColorUtils.colorToInt(lightScheme.onPrimary).toRadixString(16).substring(2)}),
        primaryContainer: Color(0x${ColorUtils.colorToInt(lightScheme.primaryContainer).toRadixString(16).substring(2)}),
        onPrimaryContainer: Color(0x${ColorUtils.colorToInt(lightScheme.onPrimaryContainer).toRadixString(16).substring(2)}),
        secondary: Color(0x${ColorUtils.colorToInt(lightScheme.secondary).toRadixString(16).substring(2)}),
        onSecondary: Color(0x${ColorUtils.colorToInt(lightScheme.onSecondary).toRadixString(16).substring(2)}),
        secondaryContainer: Color(0x${ColorUtils.colorToInt(lightScheme.secondaryContainer).toRadixString(16).substring(2)}),
        onSecondaryContainer: Color(0x${ColorUtils.colorToInt(lightScheme.onSecondaryContainer).toRadixString(16).substring(2)}),
        tertiary: Color(0x${ColorUtils.colorToInt(lightScheme.tertiary).toRadixString(16).substring(2)}),
        onTertiary: Color(0x${ColorUtils.colorToInt(lightScheme.onTertiary).toRadixString(16).substring(2)}),
        tertiaryContainer: Color(0x${ColorUtils.colorToInt(lightScheme.tertiaryContainer).toRadixString(16).substring(2)}),
        onTertiaryContainer: Color(0x${ColorUtils.colorToInt(lightScheme.onTertiaryContainer).toRadixString(16).substring(2)}),
        error: Color(0x${ColorUtils.colorToInt(lightScheme.error).toRadixString(16).substring(2)}),
        onError: Color(0x${ColorUtils.colorToInt(lightScheme.onError).toRadixString(16).substring(2)}),
        errorContainer: Color(0x${ColorUtils.colorToInt(lightScheme.errorContainer).toRadixString(16).substring(2)}),
        onErrorContainer: Color(0x${ColorUtils.colorToInt(lightScheme.onErrorContainer).toRadixString(16).substring(2)}),
        surface: Color(0x${ColorUtils.colorToInt(lightScheme.surface).toRadixString(16).substring(2)}),
        onSurface: Color(0x${ColorUtils.colorToInt(lightScheme.onSurface).toRadixString(16).substring(2)}),
        surfaceContainerHighest: Color(0x${ColorUtils.colorToInt(lightScheme.surfaceContainerHighest).toRadixString(16).substring(2)}),
        onSurfaceVariant: Color(0x${ColorUtils.colorToInt(lightScheme.onSurfaceVariant).toRadixString(16).substring(2)}),
        outline: Color(0x${ColorUtils.colorToInt(lightScheme.outline).toRadixString(16).substring(2)}),
        outlineVariant: Color(0x${ColorUtils.colorToInt(lightScheme.outlineVariant).toRadixString(16).substring(2)}),
        shadow: Color(0x${ColorUtils.colorToInt(lightScheme.shadow).toRadixString(16).substring(2)}),
        scrim: Color(0x${ColorUtils.colorToInt(lightScheme.scrim).toRadixString(16).substring(2)}),
        inverseSurface: Color(0x${ColorUtils.colorToInt(lightScheme.inverseSurface).toRadixString(16).substring(2)}),
        onInverseSurface: Color(0x${ColorUtils.colorToInt(lightScheme.onInverseSurface).toRadixString(16).substring(2)}),
        inversePrimary: Color(0x${ColorUtils.colorToInt(lightScheme.inversePrimary).toRadixString(16).substring(2)}),
      ),${hasCustomTokens ? '\n      extensions: <ThemeExtension<dynamic>>[\n        CustomColors.light,\n      ],' : ''}
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0x${ColorUtils.colorToInt(darkScheme.primary).toRadixString(16).substring(2)}),
        onPrimary: Color(0x${ColorUtils.colorToInt(darkScheme.onPrimary).toRadixString(16).substring(2)}),
        primaryContainer: Color(0x${ColorUtils.colorToInt(darkScheme.primaryContainer).toRadixString(16).substring(2)}),
        onPrimaryContainer: Color(0x${ColorUtils.colorToInt(darkScheme.onPrimaryContainer).toRadixString(16).substring(2)}),
        secondary: Color(0x${ColorUtils.colorToInt(darkScheme.secondary).toRadixString(16).substring(2)}),
        onSecondary: Color(0x${ColorUtils.colorToInt(darkScheme.onSecondary).toRadixString(16).substring(2)}),
        secondaryContainer: Color(0x${ColorUtils.colorToInt(darkScheme.secondaryContainer).toRadixString(16).substring(2)}),
        onSecondaryContainer: Color(0x${ColorUtils.colorToInt(darkScheme.onSecondaryContainer).toRadixString(16).substring(2)}),
        tertiary: Color(0x${ColorUtils.colorToInt(darkScheme.tertiary).toRadixString(16).substring(2)}),
        onTertiary: Color(0x${ColorUtils.colorToInt(darkScheme.onTertiary).toRadixString(16).substring(2)}),
        tertiaryContainer: Color(0x${ColorUtils.colorToInt(darkScheme.tertiaryContainer).toRadixString(16).substring(2)}),
        onTertiaryContainer: Color(0x${ColorUtils.colorToInt(darkScheme.onTertiaryContainer).toRadixString(16).substring(2)}),
        error: Color(0x${ColorUtils.colorToInt(darkScheme.error).toRadixString(16).substring(2)}),
        onError: Color(0x${ColorUtils.colorToInt(darkScheme.onError).toRadixString(16).substring(2)}),
        errorContainer: Color(0x${ColorUtils.colorToInt(darkScheme.errorContainer).toRadixString(16).substring(2)}),
        onErrorContainer: Color(0x${ColorUtils.colorToInt(darkScheme.onErrorContainer).toRadixString(16).substring(2)}),
        surface: Color(0x${ColorUtils.colorToInt(darkScheme.surface).toRadixString(16).substring(2)}),
        onSurface: Color(0x${ColorUtils.colorToInt(darkScheme.onSurface).toRadixString(16).substring(2)}),
        surfaceContainerHighest: Color(0x${ColorUtils.colorToInt(darkScheme.surfaceContainerHighest).toRadixString(16).substring(2)}),
        onSurfaceVariant: Color(0x${ColorUtils.colorToInt(darkScheme.onSurfaceVariant).toRadixString(16).substring(2)}),
        outline: Color(0x${ColorUtils.colorToInt(darkScheme.outline).toRadixString(16).substring(2)}),
        outlineVariant: Color(0x${ColorUtils.colorToInt(darkScheme.outlineVariant).toRadixString(16).substring(2)}),
        shadow: Color(0x${ColorUtils.colorToInt(darkScheme.shadow).toRadixString(16).substring(2)}),
        scrim: Color(0x${ColorUtils.colorToInt(darkScheme.scrim).toRadixString(16).substring(2)}),
        inverseSurface: Color(0x${ColorUtils.colorToInt(darkScheme.inverseSurface).toRadixString(16).substring(2)}),
        onInverseSurface: Color(0x${ColorUtils.colorToInt(darkScheme.onInverseSurface).toRadixString(16).substring(2)}),
        inversePrimary: Color(0x${ColorUtils.colorToInt(darkScheme.inversePrimary).toRadixString(16).substring(2)}),
      ),${hasCustomTokens ? '\n      extensions: <ThemeExtension<dynamic>>[\n        CustomColors.dark,\n      ],' : ''}
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
        'primary':
            ColorUtils.colorToHex(themeModel.colorSchemeModel.primarySeed),
        'secondary':
            ColorUtils.colorToHex(themeModel.colorSchemeModel.secondarySeed),
        'tertiary':
            ColorUtils.colorToHex(themeModel.colorSchemeModel.tertiarySeed),
        'neutral':
            ColorUtils.colorToHex(themeModel.colorSchemeModel.neutralSeed),
      },
      'light': _tokenMapToJson(themeModel.colorSchemeModel.lightTokens),
      'dark': _tokenMapToJson(themeModel.colorSchemeModel.darkTokens),
    };

    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }

  static String _generateCssCustomProperties(ThemeDataModel themeModel) {
    final buffer = StringBuffer();
    buffer
        .writeln('/* Generated Material Theme Builder - ${themeModel.name} */');
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
        'light': _generateDesignTokensForMode(
            themeModel.colorSchemeModel.lightTokens),
        'dark': _generateDesignTokensForMode(
            themeModel.colorSchemeModel.darkTokens),
      }
    };

    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(tokens);
  }

  static Map<String, dynamic> _generateDesignTokensForMode(
      Map<String, ColorToken> tokens) {
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
        'argb': ColorUtils.colorToInt(token.effectiveValue),
        'isCustomized': token.isCustomized,
        'description': token.description,
      };
    });

    return result;
  }

  static String _sanitizeFileName(String name) {
    return name
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_')
        .toLowerCase();
  }

  static String _generateThemeExtensionCode(
      CustomTokenService customTokenService, String? className) {
    return customTokenService
        .generateThemeExtensionCode(className ?? 'CustomColors');
  }

  static String _toCamelCase(String name) {
    final words = name.split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return 'Theme';

    final result = words.first.toLowerCase() +
        words
            .skip(1)
            .map((word) => word.isEmpty
                ? ''
                : word[0].toUpperCase() + word.substring(1).toLowerCase())
            .join('');

    return result.isEmpty
        ? 'Theme'
        : result[0].toUpperCase() + result.substring(1);
  }
}
