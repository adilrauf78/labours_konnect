import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();
  // Get the current user's ID from AuthController
  String get currentUserId => Get.find<AuthController>().currentUserId;


// Generate a unique chat ID for two users
  String _generateChatId(String user1, String user2) {
    final List<String> users = [user1, user2]..sort();
    return users.join('_'); // e.g., "user1_user2"
  }

  // Send a message
  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      // Generate the chat ID
      final chatId = _generateChatId(currentUserId, receiverId);

      // Create the message
      final chat = ChatModel(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message.trim(),
        timestamp:  null,
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
      }, SetOptions(merge: true));


    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Get messages between two users
  Stream<List<ChatModel>> getMessages(String senderId, String receiverId) {
    // Generate the chat ID
    final chatId = _generateChatId(senderId, receiverId);

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


  Stream<List<Map<String, dynamic>>> getChattedUsers() {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) {
      final List<Map<String, dynamic>> users = [];

      for (final doc in snapshot.docs) {
        final participants = List<String>.from(doc['participants']);
        final otherUserId = participants.firstWhere(
              (id) => id != currentUserId,
          orElse: () => '',
        );

        if (otherUserId.isNotEmpty) {
          users.add({
            'userId': otherUserId,
            'chatId': doc.id,
            'lastMessage': doc['lastMessage'],
            'timestamp': doc['timestamp'],
          });
        }
      }

      return users;
    });
  }


  // Update user status
  Future<void> updateUserStatus(String userId, bool isOnline) async {
    await _firestore.collection('users').doc(userId).update({
      'status': isOnline ? 'online' : 'offline',
      'lastSeen': DateTime.now(),
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