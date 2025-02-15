class ChatModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final bool isSeen;

  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.isSeen = false,
  });

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'isSeen': isSeen,
    };
  }

  // Create from JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp'].toDate(),
      isSeen: json['isSeen'],
    );
  }
}