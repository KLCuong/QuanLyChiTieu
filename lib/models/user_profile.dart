class UserProfile {
  final String id;
  final String? fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? address;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      gender: json['gender'],
      address: json['address'],
      role: json['role'] ?? 'user',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
