import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();
  String get currentUserId => Get.find<AuthController>().currentUserId;



  // Send a message
  Future<void> sendMessage({required String receiverId, required String message,}) async {

    try {
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      final chat = ChatModel(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message.trim(),
        timestamp: DateTime.now(),
      );

      await _firestore.collection('chats').add(chat.toMap());
      messageController.clear();
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Get messages between two users
  Stream<List<ChatModel>> getMessages(String senderId, String receiverId) {
    //print('Fetching messages for sender: $senderId and receiver: $receiverId');
    return _firestore
        .collection('chats')
        .where('senderId', whereIn: [senderId, receiverId])
        .where('receiverId', whereIn: [senderId, receiverId])
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatModel.fromMap(doc.data())).toList();
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

  Future<void> deleteMessage(String messageId) async {
    await _firestore.collection('chats').doc(messageId).delete();
  }
}