class UserProfile {
  const UserProfile({
    this.name = '',
    this.emergencyPhone = '',
    this.trustedContactName = '',
    this.preferences = '',
  });

  final String name;
  final String emergencyPhone;
  final String trustedContactName;
  final String preferences;

  bool get hasAnyData =>
      name.trim().isNotEmpty ||
      emergencyPhone.trim().isNotEmpty ||
      trustedContactName.trim().isNotEmpty ||
      preferences.trim().isNotEmpty;

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
  }) {
    return UserProfile(
      name: name ?? this.name,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      trustedContactName: trustedContactName ?? this.trustedContactName,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, Object?> toJson() => {
        'name': name,
        'emergencyPhone': emergencyPhone,
        'trustedContactName': trustedContactName,
        'preferences': preferences,
      };

  factory UserProfile.fromJson(Map<String, Object?> json) => UserProfile(
        name: json['name'] as String? ?? '',
        emergencyPhone: json['emergencyPhone'] as String? ?? '',
        trustedContactName: json['trustedContactName'] as String? ?? '',
        preferences: json['preferences'] as String? ?? '',
      );
}
