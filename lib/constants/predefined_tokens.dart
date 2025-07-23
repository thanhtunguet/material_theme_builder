import 'package:flutter/material.dart';
import '../models/custom_color_token.dart';

class PredefinedTokens {
  static final Map<String, Map<String, dynamic>> tokenDefinitions = {
    'warning': {
      'description': 'Warning color for alerts and attention-grabbing elements',
      'lightValue': Colors.orange,
      'darkValue': Colors.orange.shade300,
    },
    'onWarning': {
      'description': 'Text/icon color that appears on warning backgrounds',
      'lightValue': Colors.white,
      'darkValue': Colors.black,
    },
    'warningContainer': {
      'description': 'Container color for warning elements',
      'lightValue': Colors.orange.shade50,
      'darkValue': Colors.orange.shade900,
    },
    'onWarningContainer': {
      'description': 'Text/icon color on warning container backgrounds',
      'lightValue': Colors.orange.shade900,
      'darkValue': Colors.orange.shade100,
    },
    'information': {
      'description': 'Information color for neutral informational content',
      'lightValue': Colors.blue,
      'darkValue': Colors.blue.shade300,
    },
    'onInformation': {
      'description': 'Text/icon color that appears on information backgrounds',
      'lightValue': Colors.white,
      'darkValue': Colors.black,
    },
    'informationContainer': {
      'description': 'Container color for informational elements',
      'lightValue': Colors.blue.shade50,
      'darkValue': Colors.blue.shade900,
    },
    'onInformationContainer': {
      'description': 'Text/icon color on information container backgrounds',
      'lightValue': Colors.blue.shade900,
      'darkValue': Colors.blue.shade100,
    },
    'success': {
      'description': 'Success color for positive actions and confirmations',
      'lightValue': Colors.green,
      'darkValue': Colors.green.shade300,
    },
    'onSuccess': {
      'description': 'Text/icon color that appears on success backgrounds',
      'lightValue': Colors.white,
      'darkValue': Colors.black,
    },
    'successContainer': {
      'description': 'Container color for success elements',
      'lightValue': Colors.green.shade50,
      'darkValue': Colors.green.shade900,
    },
    'onSuccessContainer': {
      'description': 'Text/icon color on success container backgrounds',
      'lightValue': Colors.green.shade900,
      'darkValue': Colors.green.shade100,
    },
    'defaultColor': {
      'description': 'Default/neutral color for general UI elements',
      'lightValue': Colors.grey.shade600,
      'darkValue': Colors.grey.shade400,
    },
    'onDefault': {
      'description': 'Text/icon color that appears on default backgrounds',
      'lightValue': Colors.white,
      'darkValue': Colors.black,
    },
    'defaultContainer': {
      'description': 'Container color for default/neutral elements',
      'lightValue': Colors.grey.shade100,
      'darkValue': Colors.grey.shade800,
    },
    'onDefaultContainer': {
      'description': 'Text/icon color on default container backgrounds',
      'lightValue': Colors.grey.shade900,
      'darkValue': Colors.grey.shade100,
    },
    'critical': {
      'description': 'Critical color for destructive actions and errors',
      'lightValue': Colors.red,
      'darkValue': Colors.red.shade300,
    },
    'onCritical': {
      'description': 'Text/icon color that appears on critical backgrounds',
      'lightValue': Colors.white,
      'darkValue': Colors.black,
    },
  };

  static List<CustomColorToken> generatePredefinedTokens() {
    return tokenDefinitions.entries.map((entry) {
      final tokenName = entry.key;
      final definition = entry.value;

      return CustomColorToken(
        id: 'predefined_$tokenName',
        name: _formatTokenName(tokenName),
        description: definition['description'],
        lightValue: definition['lightValue'],
        darkValue: definition['darkValue'],
        isPredefined: true,
      );
    }).toList();
  }

  static String _formatTokenName(String tokenName) {
    if (tokenName == 'defaultColor') return 'Default';

    return tokenName
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .split(' ')
        .map((word) =>
            word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static bool isPredefinedToken(String name) {
    final normalizedName = name.toLowerCase().replaceAll(' ', '');
    return tokenDefinitions.keys.any((key) =>
        key.toLowerCase() == normalizedName ||
        _formatTokenName(key).toLowerCase().replaceAll(' ', '') ==
            normalizedName);
  }

  static List<String> getSemanticCategories() {
    return [
      'Warning',
      'Information',
      'Success',
      'Default',
      'Critical',
    ];
  }

  static List<CustomColorToken> getTokensForCategory(
      List<CustomColorToken> tokens, String category) {
    final categoryLower = category.toLowerCase();
    return tokens.where((token) {
      final tokenNameLower = token.name.toLowerCase();
      return tokenNameLower.contains(categoryLower);
    }).toList();
  }
}
