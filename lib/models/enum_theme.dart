import 'package:flutter/material.dart';

class EnumTheme extends ThemeExtension<EnumTheme> {
  static final colorKeys = [
    'warning',
    'onWarning',
    'warningContainer',
    'onWarningContainer',
    'information',
    'onInformation',
    'informationContainer',
    'onInformationContainer',
    'success',
    'onSuccess',
    'successContainer',
    'onSuccessContainer',
    'defaultColor',
    'onDefault',
    'defaultContainer',
    'onDefaultContainer',
    'critical',
    'onCritical'
  ];

  final Brightness brightness;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color information;
  final Color onInformation;
  final Color informationContainer;
  final Color onInformationContainer;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color defaultColor;
  final Color onDefault;
  final Color defaultContainer;
  final Color onDefaultContainer;
  final Color critical;
  final Color onCritical;

  const EnumTheme({
    required this.brightness,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.information,
    required this.onInformation,
    required this.informationContainer,
    required this.onInformationContainer,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.defaultColor,
    required this.onDefault,
    required this.defaultContainer,
    required this.onDefaultContainer,
    required this.critical,
    required this.onCritical,
  });

  Color getBackgroundColor(String key) {
    switch (key) {
      case 'warning':
        return warningContainer;
      case 'processing':
        return informationContainer;
      case 'success':
        return successContainer;
      case 'critical':
        return critical;
      case 'error':
        return critical;
      case 'defaultColor':
        return defaultContainer;
      default:
        return defaultColor;
    }
  }

  Color getTextColor(String key) {
    switch (key) {
      case 'warning':
        return onWarningContainer;
      case 'processing':
        return onInformationContainer;
      case 'success':
        return onSuccessContainer;
      case 'critical':
        return onCritical;
      case 'error':
        return onCritical;
      case 'defaultColor':
        return onDefaultContainer;
      default:
        return onDefault;
    }
  }

  Color fromKey(String key) {
    switch (key) {
      case 'warning':
        return warning;
      case 'onWarning':
        return onWarning;
      case 'warningContainer':
        return warningContainer;
      case 'onWarningContainer':
        return onWarningContainer;
      case 'information':
        return information;
      case 'onInformation':
        return onInformation;
      case 'informationContainer':
        return informationContainer;
      case 'onInformationContainer':
        return onInformationContainer;
      case 'success':
        return success;
      case 'onSuccess':
        return onSuccess;
      case 'successContainer':
        return successContainer;
      case 'onSuccessContainer':
        return onSuccessContainer;
      case 'default':
      case 'defaultColor':
        return defaultColor;
      case 'onDefault':
        return onDefault;
      case 'defaultContainer':
        return defaultContainer;
      case 'onDefaultContainer':
        return onDefaultContainer;
      default:
        return defaultColor;
    }
  }

  @override
  ThemeExtension<EnumTheme> copyWith({
    Brightness? brightness,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? information,
    Color? onInformation,
    Color? informationContainer,
    Color? onInformationContainer,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? defaultColor,
    Color? onDefault,
    Color? critical,
    Color? onCritical,
    Color? defaultContainer,
    Color? onDefaultContainer,
  }) {
    return EnumTheme(
      brightness: brightness ?? this.brightness,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      information: information ?? this.information,
      onInformation: onInformation ?? this.onInformation,
      informationContainer: informationContainer ?? this.informationContainer,
      onInformationContainer:
          onInformationContainer ?? this.onInformationContainer,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      defaultColor: defaultColor ?? this.defaultColor,
      onDefault: onDefault ?? this.onDefault,
      defaultContainer: defaultContainer ?? this.defaultContainer,
      critical: critical ?? this.critical,
      onCritical: onCritical ?? this.onCritical,
      onDefaultContainer: onDefaultContainer ?? this.onDefaultContainer,
    );
  }

  @override
  ThemeExtension<EnumTheme> lerp(
    covariant ThemeExtension<EnumTheme>? other,
    double t,
  ) {
    if (other is! EnumTheme) {
      return this;
    }

    return EnumTheme(
      brightness: brightness,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t) ??
              warningContainer,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t) ??
              onWarningContainer,
      information: Color.lerp(information, other.information, t) ?? information,
      onInformation:
          Color.lerp(onInformation, other.onInformation, t) ?? onInformation,
      informationContainer:
          Color.lerp(informationContainer, other.informationContainer, t) ??
              informationContainer,
      onInformationContainer:
          Color.lerp(onInformationContainer, other.onInformationContainer, t) ??
              onInformationContainer,
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t) ??
              successContainer,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t) ??
              onSuccessContainer,
      defaultColor:
          Color.lerp(defaultColor, other.defaultColor, t) ?? defaultColor,
      onDefault: Color.lerp(onDefault, other.onDefault, t) ?? onDefault,
      defaultContainer:
          Color.lerp(defaultContainer, other.defaultContainer, t) ??
              defaultContainer,
      onDefaultContainer:
          Color.lerp(onDefaultContainer, other.onDefaultContainer, t) ??
              onDefaultContainer,
      critical: Color.lerp(critical, other.critical, t) ?? critical,
      onCritical: Color.lerp(onCritical, other.onCritical, t) ?? onCritical,
    );
  }
}
