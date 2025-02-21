import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';
import 'package:labours_konnect/services/notification/notification.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationServices notificationServices = NotificationServices();
  final TextEditingController messageController = TextEditingController();
  // Get the current user's ID from AuthController
  String get currentUserId => Get.find<AuthController>().currentUserId;


// Generate a unique chat ID for two users
  String generateChatId(String user1, String user2) {
    final List<String> users = [user1, user2]..sort();
    return users.join('_'); // e.g., "user1_user2"
  }

  // Send a message
  Future<void> sendMessage({required String receiverId, required String message,}) async {
    try {
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      // Generate the chat ID
      final chatId = generateChatId(currentUserId, receiverId);

      // Create the message
      final chat = ChatModel(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message.trim(),
        timestamp:  null,
        status: 'sent',
      );
      messageController.clear();
      // Add the message to the "messages" subcollection
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(chat.toMap());
      // Update the chat document with the last message and timestamp
      await _firestore.collection('chats').doc(chatId).set({
        'participants': [currentUserId, receiverId],
        'lastMessage': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'unreadCount': FieldValue.increment(1),
      }, SetOptions(merge: true));
      // Send a notification to the receiver
      await notificationServices.sendNotification(receiverId: receiverId, message: message);

    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Get messages between two users
  Stream<List<ChatModel>> getMessages(String senderId, String receiverId) {
    // Generate the chat ID
    final chatId = generateChatId(senderId, receiverId);

    // Fetch messages from the "messages" subcollection
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatModel.fromMap(doc.data());
      }).toList();
    });
  }

  //fetch message screen all messages user
  Stream<List<Map<String, dynamic>>> getChattedUsers() {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<Map<String, dynamic>> users = [];
      final Set<String> userIds = {};

      //Collect all unique user IDs
      for (final doc in snapshot.docs) {
        final data = doc.data();
        if (!data.containsKey('participants')) continue;

        final participants = List<String>.from(data['participants']);
        final otherUserId = participants.firstWhere(
              (id) => id != currentUserId,
          orElse: () => '',
        );

        if (otherUserId.isNotEmpty) {
          userIds.add(otherUserId);
        }
      }

      // fetch user details
      final List<DocumentSnapshot> userDocs = await Future.wait(
        userIds.map((id) => _firestore.collection('users').doc(id).get()),
      );

      final Map<String, Map<String, dynamic>> userDetails = {};
      for (var doc in userDocs) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          final firstName = data['First Name'] ?? '';
          final lastName = data['Last Name'] ?? '';
          final fullName = '$firstName $lastName'.trim();
          final profilePicture = data['profilePicture'] ?? ''; // Fetch profile picture URL

          userDetails[doc.id] = {
            'userName': fullName.isNotEmpty ? fullName : 'Unknown',
            'profilePicture': profilePicture, // Include profile picture
          };
        }
      }

      // chat documents and add user data
      for (final doc in snapshot.docs) {
        final data = doc.data();
        if (!data.containsKey('participants')) continue;

        final participants = List<String>.from(data['participants']);
        final otherUserId = participants.firstWhere(
              (id) => id != currentUserId,
          orElse: () => '',
        );

        if (otherUserId.isNotEmpty) {
          users.add({
            'userId': otherUserId,
            'userName': userDetails[otherUserId]?['userName'] ?? 'Unknown',
            'profilePicture': userDetails[otherUserId]?['profilePicture'] ?? '',
            'chatId': doc.id,
            'lastMessage': data['lastMessage'] ?? '',
            'timestamp': data.containsKey('timestamp') ? data['timestamp'] : null,
            'unreadCount': data['unreadCount'] ?? 0,
          });

        }
      }

      return users;
    });
  }

  //reset unread
  Future<void> resetUnreadCount(String chatId) async {
    try {
      await _firestore.collection('chats').doc(chatId).update({
        'unreadCount': 0, // Reset unreadCount to 0
      });
      //print('Unread count reset for chatId: $chatId'); // Debug log
    } catch (e) {
      print('Failed to reset unread count: $e');
    }
  }

  //seen & unseen function

  Future<void> markMessagesAsSeen(String otherUserId) async {
    try {
      // Generate the chat ID
      final chatId = generateChatId(currentUserId, otherUserId);

      // Fetch all messages in the chat where the receiver is the current user
      final messages = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('receiverId', isEqualTo: currentUserId)
          .where('status', whereIn: ['sent', 'delivered'])
          .get();

      for (final doc in messages.docs) {
        // final messageId = doc.id;
        // print('Updating message $messageId to "seen"');

        await doc.reference.update({'status': 'seen'});
      }
      // Reset unreadCount to 0
      // await _firestore.collection('chats').doc(chatId).update({
      //   'unreadCount': 0,
      // });
    } catch (e) {
      throw Exception('Failed to mark messages as seen: $e');
    }
  }
  Future<void> updateUserStatus(String userId, bool isOnline) async {
    try {
      await FirebaseDatabase.instance.ref('users/$userId').update({
        'status': isOnline ? 'online' : 'offline',
      });
      //print('Updated user $userId status to ${isOnline ? 'online' : 'offline'}'); // Debug log
    } catch (e) {
      print('Failed to update user status: $e');
    }
  }
  // Update user status
  Stream<Map<String, dynamic>> Online(String userId) {
    return FirebaseDatabase.instance
        .ref('users/$userId/status')
        .onValue
        .map((event) {
      final status = event.snapshot.value ?? 'offline';
      //print('Fetched status for user $userId: $status'); // Debug log
      return {'status': status};
    });
  }

  // Update typing status
  Future<void> updateTypingStatus(String chatId, String userId, bool isTyping) async {
    await _firestore.collection('chats').doc(chatId).update({
      'typingStatus': {
        userId: isTyping,
      },
    });
  }

  // Stream to listen to typing status
  Stream<Map<String, dynamic>> getTypingStatus(String chatId) {
    return _firestore.collection('chats').doc(chatId).snapshots().map((snapshot) {
      return snapshot.data()?['typingStatus'] ?? {};
    });
  }
  // Get user status
  Stream<Map<String, dynamic>> getUserStatus(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((snapshot) {
      return snapshot.data() ?? {};
    });
  }

  Future<void> deleteMessage(String chatId, String messageId) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }
}