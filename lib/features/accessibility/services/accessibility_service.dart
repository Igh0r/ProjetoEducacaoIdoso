part of 'package:educacao_idoso/main.dart';

class AccessibilityService {
  const AccessibilityService();

  TextScaler textScalerFor(AccessibilitySettings settings) => TextScaler.linear(settings.textScale);
}

const accessibilityService = AccessibilityService();
