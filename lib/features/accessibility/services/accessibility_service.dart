import 'package:flutter/widgets.dart';
import 'package:educacao_idoso/features/accessibility/models/accessibility_settings.dart';

class AccessibilityService {
  const AccessibilityService();

  TextScaler textScalerFor(AccessibilitySettings settings) => TextScaler.linear(settings.textScale);
}

const accessibilityService = AccessibilityService();
