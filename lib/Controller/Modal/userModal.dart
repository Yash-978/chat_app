class UserModel {
  String? name, email, image, token, phone;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.token,
    required this.phone,
  });

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      name: m1['name'],
      email: m1['email'],
      image: m1['image'],
      token: m1['token'],
      phone: m1['phone'],
    );
  }

  Map<String, String?> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'token': user.token,
      'phone': user.phone,
    };
  }
}
