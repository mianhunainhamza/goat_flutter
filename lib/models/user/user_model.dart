class UserModel {
  final String userId;
  final String email;
  final String name;
  final String role;
  final String profileImage;
  final String token;
  final int enabled;
  final String address;
  final String phone;
  final String timeZone;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.profileImage,
    required this.token,
    required this.enabled,
    required this.address,
    required this.phone,
    required this.timeZone,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      profileImage: data['profileImage'] ?? '',
      token: data['token'] ?? '',
      enabled: data['enabled'] ?? 0,
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      timeZone: data['timeZone'] ?? 'Chicago UTC-06:00',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'role': role,
      'profileImage': profileImage,
      'token': token,
      'enabled': enabled,
      'address': address,
      'phone': phone,
      'timeZone': timeZone,
    };
  }
}
