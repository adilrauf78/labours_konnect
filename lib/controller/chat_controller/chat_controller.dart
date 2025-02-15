import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message
  Future<void> sendMessage(ChatModel chat) async {
    await _firestore.collection('chats').add(chat.toJson());
  }

  // Get messages between two users
  Stream<List<ChatModel>> getMessages(String senderId, String receiverId) {
    return _firestore
        .collection('chats')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
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