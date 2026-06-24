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

  Map<String, Object> toLocalProgressJson() => {
        'textScale': textScale,
        'highContrast': highContrast,
        'lowLightTheme': lowLightTheme,
        'buttonScale': buttonScale,
        'contentSpacing': contentSpacing,
        'dyslexiaFriendlyFont': dyslexiaFriendlyFont,
        'readAloudEnabled': readAloudEnabled,
      };

  factory AccessibilitySettings.fromLocalProgressJson(Map<String, Object?> json) => AccessibilitySettings(
        textScale: (json['textScale'] as num?)?.toDouble() ?? 1,
        highContrast: json['highContrast'] as bool? ?? true,
        lowLightTheme: json['lowLightTheme'] as bool? ?? false,
        buttonScale: (json['buttonScale'] as num?)?.toDouble() ?? 1,
        contentSpacing: (json['contentSpacing'] as num?)?.toDouble() ?? 1,
        dyslexiaFriendlyFont: json['dyslexiaFriendlyFont'] as bool? ?? false,
        readAloudEnabled: json['readAloudEnabled'] as bool? ?? false,
      );

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
