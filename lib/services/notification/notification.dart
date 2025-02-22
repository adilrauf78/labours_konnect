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
  final String _privateKey = """
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC2mNtgKut6tJGs
d2WVh+I/4Z1w5i/wGZOOYW0tPcbbzCcRtHQhjtworba4GlLM4UOIpCzYRj6Sb8eH
IhrhpfhPbNszDsAGX0IcXvK+G6WPT1Ri6YPOwhc4EUNoUwjA18OU1LyFCxhfZvvp
uw6ZM8y32ZnsUI/N7ky0aq71rL+y/hFjDVB8I3uj+7s/rfU2ZrEx1KOS80TyaP3l
yoEbVyXbZbPpY/URT6URXAuHZ09oy6jsIqsDL9Skub0kWXRHBDCAVWKBrOmG6f24
qaz0OVrQEW0JTAfsfctOvIQfCRN5WMqK4aslfH0VPCP7k+WA/9GKHae1na2zRx3R
b37e/eEFAgMBAAECggEAE6QAKilJCFCBQCqHmWdIWtQLJKhd4lbzRuQL46CQJ0xK
V4kwL1E339hE8ytBr2/7h6hrz8eegLnX8x0kBGmJ0AvxeAh6Id//3cqzaZInuMaG
WS1XqYG5uvorD1RUeLRnVoxGIDlqobhowwyv1qLPvmbVkP8JY36NGaBFZCpKDxfo
8vWMryUbNJRip5XTKvYiTzcrJJuHoey0oqte5s1Y1qy0OZ7qE7USFRVjxugB7+6s
H/qmoHKpsyDmXkVMEFABjS7R6H+SZsL4HPzkOuAyUSZNHyyloeAmqL8UmwPav6Uh
9TzZDBPiE95H4steyzooxWkbA0ZGd8UNhrwf1tWMcQKBgQDvdM4K2sbiLo/KNSCO
C4bQzceh3eOufpA6Btd/+a/bOgZWEPKi90rV0GXF0EZNNkDGNvEJ4ApuXEywG5Co
V1Uq6T+n9Q5OAn+0r75AXjTsN2BTM1+pl7bRvpH99Tn2ySBAuUkoMvFR2o7lbWcY
iouz6pS4+dmv0NS2/W1YAMYvWwKBgQDDNmZoqWIIt28Re++lNtXndauxPYKT+ops
o7sFgds2Jcugb7ENou9XuMYcZtr2MPiOaHFzOARY2o/cA6n2+OGNwRm7chRoDuWa
6m0yGjCxj87xQQOUwt6Vr+pRTwcef4OUoJbIQJBeUnAx4OeMwmpJUHG5Q2S7w7eY
nL+42IB/HwKBgQCDPFMIY+sIX1hzDDbxYqPaoE0/C2sTYU4OX12QR/n3fo+mb9dr
NXkQQgzlI0bEXm2VtNrZ/K362h81jYX0nRiSUg+PL6FNY9U14/OzN25t39OtBcTy
H7IUtgsxUksYVBaXInVT0Metgsk6OIF+U8BJNNGZp2WFFEDgoXhh+NqlbQKBgAhX
Gqj+E6IrtCMbGHIGlbz92ggIiLupyKA7npHtql/13W1NWFMs0uz8h/pOqqw6C2SK
Mc6qZgUl0V+lCG301C4qQd8wUI7hlA26Vk/9rnbnnf/Qt0ZzzO64RVqT9cnnyMdg
1RBZMdHV09VNtpbc942KUlGH/5XGFuH+UHKlTVghAoGABNGKHZB0n1wdppzNv/Ld
uF80CG+r+ZaMb+zKiBXpTRYEIXK+W0khOBV5vV8U1p9TQpEcn/5cgxQ9gLyCqlpc
anqGjjakPNa2t8zG1yM7jeWgcwi64ng2Zd28LpOexT6cI5inm7aUJfw4hrxn0XnC
HklA8Nb1yWIiDVe5N3k3ntE=
-----END PRIVATE KEY-----
""";
  final String _clientEmail = "labourskonnect@labourskonnect.iam.gserviceaccount.com";
  final String _projectId = "labourskonnect";


  static final NotificationServices _instance = NotificationServices._internal();

  factory NotificationServices() => _instance; // ✅ Proper singleton factory constructor

  NotificationServices._internal();

  static NotificationServices get instance => _instance;

  Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request notification permissions
    await messaging.requestPermission();

    // Handle incoming FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");
    });

    // Get FCM Token
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  }

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
      // Fetch the receiver's FCM token from Firestore
      DocumentSnapshot receiverDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .get();

      // Check if the document exists and contains the 'fcmToken' field
      if (!receiverDoc.exists || !receiverDoc.data().toString().contains('fcmToken')) {
        throw Exception('Receiver FCM token not found or user document does not exist');
      }

      String? receiverFCMToken = receiverDoc['fcmToken'];

      if (receiverFCMToken == null || receiverFCMToken.isEmpty) {
        throw Exception('Receiver FCM token is null or empty');
      }

      // Get the access token
      String accessToken = await _getAccessToken();

      // Send the notification using FCM V1 API
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

      if (response.statusCode != 200) {
        throw Exception('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send notification: $e');
    }
  }

  // Setup Firebase Messaging
}