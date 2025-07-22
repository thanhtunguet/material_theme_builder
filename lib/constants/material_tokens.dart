class MaterialTokens {
  static const List<String> primaryColors = [
    'primary',
    'onPrimary',
    'primaryContainer',
    'onPrimaryContainer',
    'primaryFixed',
    'onPrimaryFixed',
    'primaryFixedDim',
    'onPrimaryFixedVariant',
  ];

  static const List<String> secondaryColors = [
    'secondary',
    'onSecondary',
    'secondaryContainer',
    'onSecondaryContainer',
    'secondaryFixed',
    'onSecondaryFixed',
    'secondaryFixedDim',
    'onSecondaryFixedVariant',
  ];

  static const List<String> tertiaryColors = [
    'tertiary',
    'onTertiary',
    'tertiaryContainer',
    'onTertiaryContainer',
    'tertiaryFixed',
    'onTertiaryFixed',
    'tertiaryFixedDim',
    'onTertiaryFixedVariant',
  ];

  static const List<String> errorColors = [
    'error',
    'onError',
    'errorContainer',
    'onErrorContainer',
  ];

  static const List<String> surfaceColors = [
    'surface',
    'onSurface',
    'surfaceVariant',
    'onSurfaceVariant',
    'surfaceDim',
    'surfaceBright',
    'surfaceContainerLowest',
    'surfaceContainerLow',
    'surfaceContainer',
    'surfaceContainerHigh',
    'surfaceContainerHighest',
  ];

  static const List<String> outlineColors = [
    'outline',
    'outlineVariant',
  ];

  static const List<String> otherColors = [
    'shadow',
    'scrim',
    'inverseSurface',
    'onInverseSurface',
    'inversePrimary',
  ];

  static const Map<String, List<String>> tokenCategories = {
    'Primary': primaryColors,
    'Secondary': secondaryColors,
    'Tertiary': tertiaryColors,
    'Error': errorColors,
    'Surface': surfaceColors,
    'Outline': outlineColors,
    'Other': otherColors,
  };

  static const Map<String, String> tokenDescriptions = {
    'primary': 'The primary color of the theme',
    'onPrimary': 'Color used for text and icons displayed on top of the primary color',
    'primaryContainer': 'A color used for elements needing less emphasis than primary',
    'onPrimaryContainer': 'Color used for text and icons displayed on top of the primary container color',
    'primaryFixed': 'Primary fixed color for surfaces',
    'onPrimaryFixed': 'Color used for text and icons displayed on top of the primary fixed color',
    'primaryFixedDim': 'Dim version of primary fixed color',
    'onPrimaryFixedVariant': 'Variant color used for text and icons on primary fixed',
    
    'secondary': 'The secondary color of the theme',
    'onSecondary': 'Color used for text and icons displayed on top of the secondary color',
    'secondaryContainer': 'A color used for elements needing less emphasis than secondary',
    'onSecondaryContainer': 'Color used for text and icons displayed on top of the secondary container color',
    'secondaryFixed': 'Secondary fixed color for surfaces',
    'onSecondaryFixed': 'Color used for text and icons displayed on top of the secondary fixed color',
    'secondaryFixedDim': 'Dim version of secondary fixed color',
    'onSecondaryFixedVariant': 'Variant color used for text and icons on secondary fixed',
    
    'tertiary': 'The tertiary color of the theme',
    'onTertiary': 'Color used for text and icons displayed on top of the tertiary color',
    'tertiaryContainer': 'A color used for elements needing less emphasis than tertiary',
    'onTertiaryContainer': 'Color used for text and icons displayed on top of the tertiary container color',
    'tertiaryFixed': 'Tertiary fixed color for surfaces',
    'onTertiaryFixed': 'Color used for text and icons displayed on top of the tertiary fixed color',
    'tertiaryFixedDim': 'Dim version of tertiary fixed color',
    'onTertiaryFixedVariant': 'Variant color used for text and icons on tertiary fixed',
    
    'error': 'The error color of the theme',
    'onError': 'Color used for text and icons displayed on top of the error color',
    'errorContainer': 'A color used for error elements needing less emphasis',
    'onErrorContainer': 'Color used for text and icons displayed on top of the error container color',
    
    'surface': 'The surface color of the theme',
    'onSurface': 'Color used for text and icons displayed on top of the surface color',
    'surfaceVariant': 'A color variant of surface that can be used for differentiation',
    'onSurfaceVariant': 'Color used for text and icons displayed on top of the surface variant color',
    'surfaceDim': 'A dim surface color',
    'surfaceBright': 'A bright surface color',
    'surfaceContainerLowest': 'The lowest level surface container color',
    'surfaceContainerLow': 'A low level surface container color',
    'surfaceContainer': 'A surface container color',
    'surfaceContainerHigh': 'A high level surface container color',
    'surfaceContainerHighest': 'The highest level surface container color',
    
    'outline': 'Subtle color used for boundaries and dividers',
    'outlineVariant': 'A variant of outline that is more subtle',
    
    'shadow': 'Color used for shadows',
    'scrim': 'Color used for scrims',
    'inverseSurface': 'A color that contrasts with surface',
    'onInverseSurface': 'Color used for text and icons displayed on top of the inverse surface color',
    'inversePrimary': 'A color that contrasts with primary',
  };

  static List<String> getAllTokens() {
    return [
      ...primaryColors,
      ...secondaryColors,
      ...tertiaryColors,
      ...errorColors,
      ...surfaceColors,
      ...outlineColors,
      ...otherColors,
    ];
  }

  static String getTokenDescription(String token) {
    return tokenDescriptions[token] ?? 'Material Design 3 color token';
  }
}