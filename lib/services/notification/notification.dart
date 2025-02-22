import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:pointycastle/export.dart';


class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Initialize FCM and set up listeners
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Group key for grouping notifications
  final String _groupKey = 'group_key';

  // Future<void> requestNotificationPermissions() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     debugPrint('User granted permission');
  //   } else {
  //     debugPrint('User declined or has not accepted permission');
  //   }
  // }


  // Initialize notifications
  void initializeNotifications() {
    //requestNotificationPermissions();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification click
        if (response.payload != null) {
          debugPrint("Notification payload: ${response.payload}");
          Get.to(response.payload!);
        }
      },
    );
  }

  // Show notification
  void showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      groupKey: _groupKey,
      setAsGroupSummary: true,
    );

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Add a payload to handle notification clicks
    String payload = message.data['chatId'] ?? 'default_payload';

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Show grouped notification
  void showGroupedNotification(List<RemoteMessage> messages) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id', // Channel ID
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      groupKey: _groupKey,
      setAsGroupSummary: true,
    );

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Create a summary notification
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'New Messages', // Notification title
      'You have new messages', // Notification body
      platformChannelSpecifics,
    );

    // Show individual notifications
    for (var i = 0; i < messages.length; i++) {
      final message = messages[i];
      await flutterLocalNotificationsPlugin.show(
        i + 1,
        message.notification?.title, // Notification title
        message.notification?.body, // Notification body
        platformChannelSpecifics,
      );
    }
  }

  // Listen for foreground messages
  void setupFirebaseMessagingListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground Notification: ${message.notification?.title}");
      showNotification(message); // Show notification in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification Clicked: ${message.notification?.title}");
      showNotification(message);
    });
  }


  // Save FCM token to Firestore
  Future<void> saveFCMToken(String userId) async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': token,
      });
    }
  }

  // Load service account credentials from assets
  Future<Map<String, dynamic>> _loadServiceAccount() async {
    final String response = await rootBundle.loadString('assets/service_account.json');
    return jsonDecode(response);
  }

  // Generate an access token using the service account credentials
  Future<String> _generateAccessToken() async {
    final serviceAccount = await _loadServiceAccount();
    final String privateKey = serviceAccount['private_key'];
    final String clientEmail = serviceAccount['client_email'];
    final String tokenUri = serviceAccount['token_uri'];

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      'assertion': _createJWT(privateKey, clientEmail, tokenUri),
    });

    final response = await http.post(
      Uri.parse(tokenUri),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to generate access token: ${response.body}');
    }
  }

  // Create a JWT for authentication
  String _createJWT(String privateKey, String clientEmail, String tokenUri) {
    final header = {
      'alg': 'RS256',
      'typ': 'JWT',
    };

    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final payload = {
      'iss': clientEmail,
      'scope': 'https://www.googleapis.com/auth/firebase.messaging',
      'aud': tokenUri,
      'exp': currentTime + 3600,
      'iat': currentTime,
    };

    final encodedHeader = base64Url.encode(utf8.encode(jsonEncode(header)));
    final encodedPayload = base64Url.encode(utf8.encode(jsonEncode(payload)));
    final encodedSignature = base64Url.encode(_signData('$encodedHeader.$encodedPayload', privateKey));

    return '$encodedHeader.$encodedPayload.$encodedSignature';
  }

  // Sign data using the private key
  List<int> _signData(String data, String privateKeyPem) {
    final rsaparser = encrypt.RSAKeyParser();
    final privateKey = rsaparser.parse(privateKeyPem) as RSAPrivateKey;

    // Initialize the signer with SHA-256
    final signer = RSASigner(SHA256Digest(), '0609608648016503040201');

    // Initialize the signer with the private key
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    // Generate the signature
    final signature = signer.generateSignature(utf8.encode(data));

    // Return the signature bytes
    return signature.bytes;
  }

  // Send notification to a user or group
  Future<void> sendNotification({
    required String receiverId,
    required String senderId,
    required String message,
    bool isGroup = false,
    required String receiverToken,
    required String title,
    required String body,
  }) async {
    try {
      // Fetch receiver's FCM token
      final receiverDoc = await _firestore.collection('users').doc(receiverId).get();
      final String? receiverToken = receiverDoc['fcmToken'];

      if (receiverToken == null) {
        debugPrint("Receiver FCM token not found");
        return;
      }

      // Fetch sender's details
      final senderDoc = await _firestore.collection('users').doc(senderId).get();
      final String senderName = "${senderDoc['First Name']} ${senderDoc['Last Name']}";
      debugPrint("Receiver Token: $receiverToken");

      // Prepare notification payload
      final Map<String, dynamic> notificationPayload = {
        "message": {
          "token": receiverToken,
          "notification": {
            "title": isGroup ? "New Group Message" : "New Message",
            "body": "$senderName: $message",
          },
          "data": {
            "type": isGroup ? "group_message" : "direct_message",
            "senderId": senderId,
            "receiverId": receiverId,
            "message": message,
          },
        },
      };

      // Send notification using Firebase Cloud Messaging API (V1)
      await _sendFCMNotification(notificationPayload);
    } catch (e) {
      debugPrint("Error sending notification: $e");
    }
  }

  // Send FCM notification using HTTP POST request
  Future<void> _sendFCMNotification(Map<String, dynamic> payload) async {
    const String fcmUrl = 'https://fcm.googleapis.com/v1/projects/labourskonnect/messages:send';

    // Generate access token
    final String accessToken = await _generateAccessToken();

    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      debugPrint("Notification sent successfully");
    } else {
      debugPrint("Failed to send notification: ${response.body}");
    }
  }
}