

import 'dart:developer';

import 'package:chat_app/Modal/chatModal.dart';
import 'package:chat_app/Services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Modal/userModal.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel user) async {
    await fireStore.collection("users").doc(user.email).set({
      'name': user.name,
      'email': user.email,
      'token': user.token,
      'image': user.image,
      'phone': user.phone,
      'read':user.read,
      'typing':user.typing,
      'isOnline':user.isOnline,
      'timestamp':user.timestamp ,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      readCurrentUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("users").doc(user!.email).get();
  }

  //READ ALL USER FROM FIRE STORE

  Future<QuerySnapshot<Map<String, dynamic>>>
      readAllUserCloudFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore
        .collection("users")
        .where("email", isNotEqualTo: user!.email)
        .get();
  }

/*
  * add chat in fireStore
  * chatroom ->user->chat-> list chat
  * sender_receiver
  * joint
  * in this case we will just replace the sender at the same time so it can be change accordingly
  * */

  Future<void> addChatInFireStore(ChatModel chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat.toMap(chat));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(
      String receiver) {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    return fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  //data will update according to docId
  Future<void> updateChat(String receiver, String message, String dcId) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update(
      {'message': message},
    );
  }

  Future<void> removeChat(String dcId, String receiver) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .delete();
  }

  Future<void> changeOnlineStatus(bool status) async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update(
      {'isOnline': status},
    );
    final snapshot = await fireStore.collection("users").doc(email).get();
    Map? user = snapshot.data();
    log("user online status :$status: ${user!['isOnline']}");
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> findUserIsOnlineOrNot(
      String email) {
    return fireStore.collection("users").doc(email).snapshots();
  }
  // Future<void> toggleOnlineStatus(
  //     bool status, Timestamp timestamp, bool isTyping) async {
  //   String email = AuthService.authService.getCurrentUser()!.email!;
  //   await fireStore.collection("users").doc(email).update({
  //     'isOnline': status,
  //     'timestamp': timestamp,
  //     'isTyping': isTyping,
  //   });
  // }
  //
  Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIsOnlineOrNot(
      String email) {
    return fireStore.collection("users").doc(email).snapshots();
  }


  Future<void> updateLastSeen() async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'timestamp': Timestamp.now(),
    });
  }


  Future<void> toggleOnlineStatus(bool status) async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'isOnline': status,
    });
  }

  Future<void> toggleTypingStatus(bool status) async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'typing': status,
    });
  }
}
