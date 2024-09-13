import 'package:chat_app/Controller/Modal/userModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel user) async {
    await fireStore.collection("user").doc().set({
      'name': user.name,
      'email': user.email,
      'token': "--",
      'image': user.image,
      'phone': user.phone,
    });
  }
}
