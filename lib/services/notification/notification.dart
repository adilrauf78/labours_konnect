import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/view/message_screen/chat_screen/chat_screen.dart';



class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String get currentUserId => Get.find<AuthController>().currentUserId;

//Request Notification Permissions
  Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

// Store FCM Tokens
  Future<void> saveFCMToken(String userId) async {

    // Get the FCM token
    String? token = await messaging.getToken();

    if (token != null) {
      // Save the token to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'fcmToken': token,
      }, SetOptions(merge: true));
    }
  }

//Send Notifications

  Future<void> sendNotification({required String receiverId, required String message}) async {
    try {
      // Fetch the receiver's FCM token from Firestore
      DocumentSnapshot receiverDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .get();

      String? receiverFCMToken = receiverDoc['fcmToken'];

      if (receiverFCMToken == null) {
        throw Exception('Receiver FCM token not found');
      }

      // Send the notification using Firebase Cloud Messaging
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=YOUR_SERVER_KEY', // Replace with your Firebase Server Key
        },
        body: jsonEncode(<String, dynamic>{
          'to': receiverFCMToken,
          'notification': <String, dynamic>{
            'title': 'New Message',
            'body': message,
          },
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'senderId': currentUserId,
            'receiverId': receiverId,
          },
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      throw Exception('Failed to send notification: $e');
    }
  }
  void setupFirebaseMessaging() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Handle background/terminated notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');

      // Navigate to the chat screen
      String senderId = message.data['senderId'];
      String receiverId = message.data['receiverId'];
      Get.to(() => ChatScreen(
        userId: senderId,
        userName: 'Sender Name', // Fetch sender's name from Firestore
        chatId: generateChatId(senderId, receiverId),
      ));
    });
  }


}