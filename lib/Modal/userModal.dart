import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name, email, image, phone, token;
  bool? isOnline,typing,read;
   late Timestamp? timestamp;

  UserModel(
      {required this.name,
        required this.email,
        required this.image,
        required this.phone,
        required this.token,
        required this.isOnline,
        required this.typing,
        required this.timestamp,
        required this.read

      });

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      name: m1['name'],
      email: m1['email'],
      image: m1['image'],
      phone: m1['phone'],
      token: m1['token'],
      isOnline: m1['isOnline']?? false,
      typing: m1['typing']?? false,
      timestamp: m1['timestamp'], read: m1['read']?? false,);
  }

  Map<String, dynamic?> toMap(UserModel user) {
    return {
      'name': user.name ?? "",
      'email': user.email,
      'phone': user.phone,
      'image': user.image ?? "https://st3.depositphotos.com/3538469/15750/i/450/depositphotos_157501024-stock-photo-business-man-icon.jpg",
      'token': user.token,
      'read':user.read,
      'typing':user.typing,
      'isOnline':user.isOnline,
      'timestamp':user.timestamp,
    };
  }
}