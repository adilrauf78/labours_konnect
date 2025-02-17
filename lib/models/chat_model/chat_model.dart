import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime? timestamp;

  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // Convert ChatModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  // Create ChatModel from a Map
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      message: map['message'],
      timestamp: map['timestamp']?.toDate(),
    );
  }
}