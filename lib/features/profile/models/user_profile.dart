class UserProfile {
  const UserProfile({
    this.name = '',
    this.emergencyPhone = '',
    this.trustedContactName = '',
    this.preferences = '',
    this.acceptedRemoteAssistantTerms = false,
    this.acceptedRemoteAssistantTermsAt,
  });

  final String name;
  final String emergencyPhone;
  final String trustedContactName;
  final String preferences;
  final bool acceptedRemoteAssistantTerms;
  final DateTime? acceptedRemoteAssistantTermsAt;

  bool get hasAnyData =>
      name.trim().isNotEmpty ||
      emergencyPhone.trim().isNotEmpty ||
      trustedContactName.trim().isNotEmpty ||
      preferences.trim().isNotEmpty ||
      acceptedRemoteAssistantTerms;

  bool get hasTrustedContact =>
      trustedContactName.trim().isNotEmpty || emergencyPhone.trim().isNotEmpty;

  String get trustedContactLabel {
    final contact = trustedContactName.trim();
    final phone = emergencyPhone.trim();
    if (contact.isNotEmpty && phone.isNotEmpty) return '$contact ($phone)';
    if (contact.isNotEmpty) return contact;
    if (phone.isNotEmpty) return phone;
    return 'um familiar, cuidador ou contato de confiança';
  }

  UserProfile copyWith({
    String? name,
    String? emergencyPhone,
    String? trustedContactName,
    String? preferences,
    bool? acceptedRemoteAssistantTerms,
    DateTime? acceptedRemoteAssistantTermsAt,
    bool clearRemoteAssistantTermsAt = false,
  }) {
    return UserProfile(
      name: name ?? this.name,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      trustedContactName: trustedContactName ?? this.trustedContactName,
      preferences: preferences ?? this.preferences,
      acceptedRemoteAssistantTerms: acceptedRemoteAssistantTerms ?? this.acceptedRemoteAssistantTerms,
      acceptedRemoteAssistantTermsAt: clearRemoteAssistantTermsAt ? null : acceptedRemoteAssistantTermsAt ?? this.acceptedRemoteAssistantTermsAt,
    );
  }

  Map<String, Object?> toJson() => {
        'name': name,
        'emergencyPhone': emergencyPhone,
        'trustedContactName': trustedContactName,
        'preferences': preferences,
        'acceptedRemoteAssistantTerms': acceptedRemoteAssistantTerms,
        'acceptedRemoteAssistantTermsAt': acceptedRemoteAssistantTermsAt?.toIso8601String(),
      };

  factory UserProfile.fromJson(Map<String, Object?> json) => UserProfile(
        name: json['name'] as String? ?? '',
        emergencyPhone: json['emergencyPhone'] as String? ?? '',
        trustedContactName: json['trustedContactName'] as String? ?? '',
        preferences: json['preferences'] as String? ?? '',
        acceptedRemoteAssistantTerms: json['acceptedRemoteAssistantTerms'] as bool? ?? false,
        acceptedRemoteAssistantTermsAt: _parseDate(json['acceptedRemoteAssistantTermsAt']),
      );

  static DateTime? _parseDate(Object? value) {
    if (value is! String || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }
}
