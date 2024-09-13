import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(
      String name, String email, String image, String token) async {
    await fireStore.collection("users").doc().set({
      'name': name,
      'email': email,
      'token': token,
      'image': image,
    });
  }
}


