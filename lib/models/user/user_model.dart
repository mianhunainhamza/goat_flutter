class UserModel {
  final String userId;
  final String email;
  final String name;
  final String role;
  final String profileImage;
  final String token;
  final int enabled;
  final int blocked;
  final String address;
  final String phone;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.profileImage,
    required this.token,
    required this.enabled,
    required this.blocked,
    required this.address,
    required this.phone,
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
      blocked: data['blocked'] ?? 0,
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
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
      'blocked': blocked,
      'address': address,
      'phone': phone,
    };
  }
}
