import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart' as mcu;
import '../models/color_token.dart';
import '../models/color_scheme_model.dart';
import '../constants/material_tokens.dart';
import 'color_utils.dart';

class ThemeGeneratorService {
  static ColorSchemeModel generateFromSeeds({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color neutral,
  }) {
    final lightTokens = _generateLightTokens(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      neutral: neutral,
    );
    
    final darkTokens = _generateDarkTokens(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      neutral: neutral,
    );

    return ColorSchemeModel(
      primarySeed: primary,
      secondarySeed: secondary,
      tertiarySeed: tertiary,
      neutralSeed: neutral,
      lightTokens: lightTokens,
      darkTokens: darkTokens,
    );
  }

  static Map<String, ColorToken> _generateLightTokens({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color neutral,
  }) {
    final scheme = _generateMaterialColorScheme(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      neutral: neutral,
      brightness: Brightness.light,
    );

    final tokens = <String, ColorToken>{};

    for (final tokenName in MaterialTokens.getAllTokens()) {
      final color = _getColorFromScheme(scheme, tokenName);
      tokens[tokenName] = ColorToken(
        name: tokenName,
        description: MaterialTokens.getTokenDescription(tokenName),
        defaultValue: color,
        isCustomizable: true,
      );
    }

    return tokens;
  }

  static Map<String, ColorToken> _generateDarkTokens({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color neutral,
  }) {
    final scheme = _generateMaterialColorScheme(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      neutral: neutral,
      brightness: Brightness.dark,
    );

    final tokens = <String, ColorToken>{};

    for (final tokenName in MaterialTokens.getAllTokens()) {
      final color = _getColorFromScheme(scheme, tokenName);
      tokens[tokenName] = ColorToken(
        name: tokenName,
        description: MaterialTokens.getTokenDescription(tokenName),
        defaultValue: color,
        isCustomizable: true,
      );
    }

    return tokens;
  }

  static ColorScheme _generateMaterialColorScheme({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color neutral,
    required Brightness brightness,
  }) {
    final primaryArgb = primary.value;

    final scheme = brightness == Brightness.light
        ? mcu.Scheme.light(primaryArgb)
        : mcu.Scheme.dark(primaryArgb);

    return ColorScheme(
      brightness: brightness,
      primary: Color(scheme.primary),
      onPrimary: Color(scheme.onPrimary),
      primaryContainer: Color(scheme.primaryContainer),
      onPrimaryContainer: Color(scheme.onPrimaryContainer),
      secondary: Color(scheme.secondary),
      onSecondary: Color(scheme.onSecondary),
      secondaryContainer: Color(scheme.secondaryContainer),
      onSecondaryContainer: Color(scheme.onSecondaryContainer),
      tertiary: Color(scheme.tertiary),
      onTertiary: Color(scheme.onTertiary),
      tertiaryContainer: Color(scheme.tertiaryContainer),
      onTertiaryContainer: Color(scheme.onTertiaryContainer),
      error: Color(scheme.error),
      onError: Color(scheme.onError),
      errorContainer: Color(scheme.errorContainer),
      onErrorContainer: Color(scheme.onErrorContainer),
      surface: Color(scheme.surface),
      onSurface: Color(scheme.onSurface),
      surfaceVariant: Color(scheme.surfaceVariant),
      onSurfaceVariant: Color(scheme.onSurfaceVariant),
      outline: Color(scheme.outline),
      outlineVariant: Color(scheme.outlineVariant),
      shadow: Color(scheme.shadow),
      scrim: Color(scheme.scrim),
      inverseSurface: Color(scheme.inverseSurface),
      onInverseSurface: Color(scheme.inverseOnSurface),
      inversePrimary: Color(scheme.inversePrimary),
    );
  }

  static Color _getColorFromScheme(ColorScheme scheme, String tokenName) {
    switch (tokenName) {
      case 'primary':
        return scheme.primary;
      case 'onPrimary':
        return scheme.onPrimary;
      case 'primaryContainer':
        return scheme.primaryContainer;
      case 'onPrimaryContainer':
        return scheme.onPrimaryContainer;
      case 'primaryFixed':
        return scheme.primaryContainer;
      case 'onPrimaryFixed':
        return scheme.onPrimaryContainer;
      case 'primaryFixedDim':
        return ColorUtils.darken(scheme.primaryContainer, 0.1);
      case 'onPrimaryFixedVariant':
        return ColorUtils.darken(scheme.onPrimaryContainer, 0.1);
      case 'secondary':
        return scheme.secondary;
      case 'onSecondary':
        return scheme.onSecondary;
      case 'secondaryContainer':
        return scheme.secondaryContainer;
      case 'onSecondaryContainer':
        return scheme.onSecondaryContainer;
      case 'secondaryFixed':
        return scheme.secondaryContainer;
      case 'onSecondaryFixed':
        return scheme.onSecondaryContainer;
      case 'secondaryFixedDim':
        return ColorUtils.darken(scheme.secondaryContainer, 0.1);
      case 'onSecondaryFixedVariant':
        return ColorUtils.darken(scheme.onSecondaryContainer, 0.1);
      case 'tertiary':
        return scheme.tertiary;
      case 'onTertiary':
        return scheme.onTertiary;
      case 'tertiaryContainer':
        return scheme.tertiaryContainer;
      case 'onTertiaryContainer':
        return scheme.onTertiaryContainer;
      case 'tertiaryFixed':
        return scheme.tertiaryContainer;
      case 'onTertiaryFixed':
        return scheme.onTertiaryContainer;
      case 'tertiaryFixedDim':
        return ColorUtils.darken(scheme.tertiaryContainer, 0.1);
      case 'onTertiaryFixedVariant':
        return ColorUtils.darken(scheme.onTertiaryContainer, 0.1);
      case 'error':
        return scheme.error;
      case 'onError':
        return scheme.onError;
      case 'errorContainer':
        return scheme.errorContainer;
      case 'onErrorContainer':
        return scheme.onErrorContainer;
      case 'surface':
        return scheme.surface;
      case 'onSurface':
        return scheme.onSurface;
      case 'surfaceVariant':
        return scheme.surfaceVariant;
      case 'onSurfaceVariant':
        return scheme.onSurfaceVariant;
      case 'surfaceDim':
        return ColorUtils.darken(scheme.surface, 0.05);
      case 'surfaceBright':
        return ColorUtils.lighten(scheme.surface, 0.05);
      case 'surfaceContainerLowest':
        return scheme.surface;
      case 'surfaceContainerLow':
        return ColorUtils.lighten(scheme.surface, 0.02);
      case 'surfaceContainer':
        return ColorUtils.lighten(scheme.surface, 0.05);
      case 'surfaceContainerHigh':
        return ColorUtils.lighten(scheme.surface, 0.08);
      case 'surfaceContainerHighest':
        return ColorUtils.lighten(scheme.surface, 0.12);
      case 'outline':
        return scheme.outline;
      case 'outlineVariant':
        return scheme.outlineVariant;
      case 'shadow':
        return scheme.shadow;
      case 'scrim':
        return scheme.scrim;
      case 'inverseSurface':
        return scheme.inverseSurface;
      case 'onInverseSurface':
        return scheme.onInverseSurface;
      case 'inversePrimary':
        return scheme.inversePrimary;
      default:
        return scheme.primary;
    }
  }

  static ColorSchemeModel getDefaultMaterialTheme() {
    return generateFromSeeds(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      tertiary: Colors.lightBlue,
      neutral: Colors.grey,
    );
  }

  static bool validateColorContrast(ColorSchemeModel model) {
    bool isValid = true;
    
    final lightScheme = model.lightColorScheme;
    final darkScheme = model.darkColorScheme;
    
    final criticalPairs = [
      [lightScheme.primary, lightScheme.onPrimary],
      [lightScheme.secondary, lightScheme.onSecondary],
      [lightScheme.surface, lightScheme.onSurface],
      [darkScheme.primary, darkScheme.onPrimary],
      [darkScheme.secondary, darkScheme.onSecondary],
      [darkScheme.surface, darkScheme.onSurface],
    ];

    for (final pair in criticalPairs) {
      if (!ColorUtils.meetsWCAGAA(pair[0], pair[1])) {
        isValid = false;
        break;
      }
    }

    return isValid;
  }
}