part of 'package:educacao_idoso/main.dart';

class AccessibilitySettings {
  const AccessibilitySettings({
    this.textScale = 1,
    this.highContrast = true,
    this.lowLightTheme = false,
    this.buttonScale = 1,
    this.contentSpacing = 1,
    this.dyslexiaFriendlyFont = false,
    this.readAloudEnabled = false,
  });

  final double textScale;
  final bool highContrast;
  final bool lowLightTheme;
  final double buttonScale;
  final double contentSpacing;
  final bool dyslexiaFriendlyFont;
  final bool readAloudEnabled;

  AccessibilitySettings copyWith({
    double? textScale,
    bool? highContrast,
    bool? lowLightTheme,
    double? buttonScale,
    double? contentSpacing,
    bool? dyslexiaFriendlyFont,
    bool? readAloudEnabled,
  }) =>
      AccessibilitySettings(
        textScale: textScale ?? this.textScale,
        highContrast: highContrast ?? this.highContrast,
        lowLightTheme: lowLightTheme ?? this.lowLightTheme,
        buttonScale: buttonScale ?? this.buttonScale,
        contentSpacing: contentSpacing ?? this.contentSpacing,
        dyslexiaFriendlyFont: dyslexiaFriendlyFont ?? this.dyslexiaFriendlyFont,
        readAloudEnabled: readAloudEnabled ?? this.readAloudEnabled,
      );
}
