import 'dart:convert';
import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import '../models/custom_color_token.dart';
import '../models/custom_theme_extension.dart';
import '../constants/predefined_tokens.dart';

class CustomTokenService extends ChangeNotifier {
  final List<CustomColorToken> _customTokens = [];
  static const String _storageKey = 'material_theme_builder_custom_tokens';
  bool _predefinedTokensInitialized = false;

  List<CustomColorToken> get customTokens => List.unmodifiable(_customTokens);
  List<CustomColorToken> get predefinedTokens => _customTokens.where((token) => token.isPredefined).toList();
  List<CustomColorToken> get userCustomTokens => _customTokens.where((token) => !token.isPredefined).toList();

  CustomTokenService() {
    _loadFromStorage();
  }

  void addToken(CustomColorToken token) {
    _customTokens.add(token);
    _saveToStorage();
    notifyListeners();
  }

  void removeToken(String id) {
    _customTokens.removeWhere((token) => token.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void updateToken(CustomColorToken updatedToken) {
    final index = _customTokens.indexWhere((token) => token.id == updatedToken.id);
    if (index != -1) {
      _customTokens[index] = updatedToken;
      _saveToStorage();
      notifyListeners();
    }
  }

  CustomColorToken? getToken(String id) {
    try {
      return _customTokens.firstWhere((token) => token.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearAllTokens() {
    _customTokens.clear();
    _saveToStorage();
    notifyListeners();
  }

  CustomColorToken createToken({
    required String name,
    required String description,
    required Color lightValue,
    required Color darkValue,
  }) {
    final token = CustomColorToken(
      id: _generateId(),
      name: name,
      description: description,
      lightValue: lightValue,
      darkValue: darkValue,
    );
    
    addToken(token);
    return token;
  }

  List<CustomColorToken> searchTokens(String query) {
    if (query.isEmpty) return customTokens;
    
    final lowercaseQuery = query.toLowerCase();
    return _customTokens.where((token) {
      return token.name.toLowerCase().contains(lowercaseQuery) ||
          token.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  CustomThemeExtension buildLightExtension() {
    return CustomThemeExtension.fromTokens(_customTokens, Brightness.light);
  }

  CustomThemeExtension buildDarkExtension() {
    return CustomThemeExtension.fromTokens(_customTokens, Brightness.dark);
  }

  String generateThemeExtensionCode(String className) {
    if (_customTokens.isEmpty) {
      return '''
// No custom tokens defined
class $className extends ThemeExtension<$className> {
  const $className();
  
  @override
  $className copyWith() => const $className();
  
  @override
  $className lerp(ThemeExtension<$className>? other, double t) => this;
}''';
    }

    final extension = CustomThemeExtension(customColors: {});
    return extension.generateDartCode(className, _customTokens);
  }

  Map<String, dynamic> exportTokensAsJson() {
    return {
      'version': '1.0.0',
      'createdAt': DateTime.now().toIso8601String(),
      'customTokens': _customTokens.map((token) => token.toJson()).toList(),
    };
  }

  void importTokensFromJson(String jsonString) {
    try {
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> tokensData = data['customTokens'] ?? [];
      
      final List<CustomColorToken> importedTokens = tokensData
          .map((tokenData) => CustomColorToken.fromJson(tokenData))
          .toList();
      
      for (final token in importedTokens) {
        if (!_customTokens.any((existing) => existing.id == token.id)) {
          _customTokens.add(token);
        }
      }
      
      _saveToStorage();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to import tokens: $e');
    }
  }

  void _loadFromStorage() {
    try {
      final storage = html.window.localStorage[_storageKey];
      if (storage != null) {
        final Map<String, dynamic> data = json.decode(storage);
        final List<dynamic> tokensData = data['tokens'] ?? [];
        _predefinedTokensInitialized = data['predefinedTokensInitialized'] ?? false;
        
        _customTokens.clear();
        _customTokens.addAll(
          tokensData.map((tokenData) => CustomColorToken.fromJson(tokenData))
        );
      }
      
      if (!_predefinedTokensInitialized) {
        _initializePredefinedTokens();
      }
    } catch (e) {
      debugPrint('Failed to load custom tokens from storage: $e');
      if (!_predefinedTokensInitialized) {
        _initializePredefinedTokens();
      }
    }
  }

  void _initializePredefinedTokens() {
    final predefinedTokens = PredefinedTokens.generatePredefinedTokens();
    
    for (final token in predefinedTokens) {
      if (!_customTokens.any((existing) => existing.id == token.id)) {
        _customTokens.insert(0, token);
      }
    }
    
    _predefinedTokensInitialized = true;
    _saveToStorage();
    notifyListeners();
  }

  void resetPredefinedTokens() {
    _customTokens.removeWhere((token) => token.isPredefined);
    _initializePredefinedTokens();
  }

  void _saveToStorage() {
    try {
      final data = {
        'version': '1.0.0',
        'savedAt': DateTime.now().toIso8601String(),
        'predefinedTokensInitialized': _predefinedTokensInitialized,
        'tokens': _customTokens.map((token) => token.toJson()).toList(),
      };
      
      html.window.localStorage[_storageKey] = json.encode(data);
    } catch (e) {
      debugPrint('Failed to save custom tokens to storage: $e');
    }
  }

  String _generateId() {
    return 'custom_${DateTime.now().millisecondsSinceEpoch}_${_customTokens.length}';
  }

  bool validateTokenName(String name, {String? excludeId}) {
    if (name.trim().isEmpty) return false;
    if (RegExp(r'^[0-9]').hasMatch(name.trim())) return false;
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_\s]*$').hasMatch(name.trim())) return false;
    
    final dartName = CustomColorToken(
      id: 'temp',
      name: name.trim(),
      description: '',
      lightValue: Colors.black,
      darkValue: Colors.white,
    ).dartVariableName;
    
    return !_customTokens.any((token) => 
        token.id != excludeId && token.dartVariableName == dartName);
  }

  bool canRemoveToken(String id) {
    final token = getToken(id);
    return token != null && !token.isPredefined;
  }

  List<String> getTokenValidationErrors(String name, {String? excludeId}) {
    final errors = <String>[];
    
    if (name.trim().isEmpty) {
      errors.add('Token name cannot be empty');
    }
    
    if (RegExp(r'^[0-9]').hasMatch(name.trim())) {
      errors.add('Token name cannot start with a number');
    }
    
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_\s]*$').hasMatch(name.trim())) {
      errors.add('Token name can only contain letters, numbers, underscores, and spaces');
    }
    
    final dartName = name.trim().isNotEmpty ? CustomColorToken(
      id: 'temp',
      name: name.trim(),
      description: '',
      lightValue: Colors.black,
      darkValue: Colors.white,
    ).dartVariableName : '';
    
    if (_customTokens.any((token) => 
        token.id != excludeId && token.dartVariableName == dartName)) {
      errors.add('A token with this name already exists');
    }
    
    return errors;
  }
}