import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/chat_controller/chat_controller.dart';
import 'package:labours_konnect/view/message_screen/chat_screen/chat_screen.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String get currentUserId => Get.find<AuthController>().currentUserId;
  final ChatController chatController = ChatController();

  // Replace with your service account credentials
  final String _privateKey = """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC2mNtgKut6tJGs
...
HklA8Nb1yWIiDVe5N3k3ntE=
-----END PRIVATE KEY-----""";
  final String _clientEmail = "labourskonnect@labourskonnect.iam.gserviceaccount.com";
  final String _projectId = "labourskonnect";

  // Request Notification Permissions
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

  void setupFCMTokenListener() {
    messaging.onTokenRefresh.listen((newToken) async {
      User? user = auth.currentUser;
      if (user != null) {
        await fireStore.collection('users').doc(user.uid).update({
          'fcmToken': newToken,
        });
      }
    });
  }

  // Generate JWT for FCM V1 API
  Future<String> _generateJWT() async {
    final jwt = JWT(
      {
        "iss": _clientEmail,
        "scope": "https://www.googleapis.com/auth/firebase.messaging",
        "aud": "https://oauth2.googleapis.com/token",
        "exp": (DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000),
        "iat": (DateTime.now().millisecondsSinceEpoch ~/ 1000),
      },
    );

    final key = RSAPrivateKey(_privateKey);

    final token = jwt.sign(key, algorithm: JWTAlgorithm.RS256);

    return token;
  }



  // Get Access Token using JWT
  Future<String> _getAccessToken() async {
    final jwt = await _generateJWT();

    final response = await http.post(
      Uri.parse("https://oauth2.googleapis.com/token"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
        "assertion": jwt,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["access_token"];
    } else {
      throw Exception("Failed to get access token: ${response.body}");
    }
  }

  // Send Notifications using FCM V1 API
  Future<void> sendNotification({required String receiverId, required String message}) async {
    try {
      print("Fetching receiver's FCM token...");

      DocumentSnapshot receiverDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .get();

      if (!receiverDoc.exists || !receiverDoc.data().toString().contains('fcmToken')) {
        print('❌ Error: Receiver FCM token not found or user document does not exist');
        return; // Stop execution
      }

      String? receiverFCMToken = receiverDoc['fcmToken'];

      if (receiverFCMToken == null || receiverFCMToken.isEmpty) {
        print('❌ Error: Receiver FCM token is null or empty');
        return;
      }

      print("✅ Receiver's FCM token found: $receiverFCMToken");

      // Get access token
      String accessToken = await _getAccessToken();
      print("✅ Access token retrieved successfully");

      // Send notification request
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/$_projectId/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{
          "message": {
            "token": receiverFCMToken,
            "notification": {
              "title": "New Message",
              "body": message,
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "senderId": currentUserId,
              "receiverId": receiverId,
            },
          },
        }),
      );

      print("✅ Notification API response: ${response.statusCode}, ${response.body}");

      if (response.statusCode != 200) {
        print('❌ Failed to send notification: ${response.body}');
        return;
      }

      print("✅ Notification sent successfully!");
    } catch (e) {
      {
        print('❌ Exception occurred in sendNotification: $e');
      }
    }
  }


  // Setup Firebase Messaging
  void setupFirebaseMessaging() {

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
      final chatId = chatController.generateChatId(senderId, receiverId);
      Get.to(() => ChatScreen(
        userId: senderId,
        userName: 'Sender Name', // Fetch sender's name from Firestore
        chatId: chatId,
      ));
    });
  }
}