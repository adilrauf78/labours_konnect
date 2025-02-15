import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// **Send Push Notification to User**
  Future<void> sendNotification(String receiverId, String message) async {
    DocumentSnapshot userDoc =
    await _fireStore.collection('users').doc(receiverId).get();
    String? token = userDoc['fcmToken'];

    if (token != null) {
      await _firebaseMessaging.sendMessage(
        to: token,
        data: {
          'title': 'New Message',
          'body': message,
        },
      );
    }
  }
}
