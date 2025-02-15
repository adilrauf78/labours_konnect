class UserModel {
  final String userId; // Unique ID of the user
  final String userName; // Name of the user
  final String profilePicture; // URL or path to the user's profile picture
  final String email; // User's email (optional)
  final bool isOnline; // Online/offline status of the user
  final DateTime lastSeen; // Last seen timestamp

  UserModel({
    required this.userId,
    required this.userName,
    this.profilePicture = 'default_image.png', // Default image if none is provided
    this.email = '',
    this.isOnline = false,
    required this.lastSeen,
  });

  // Convert UserModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'profilePicture': profilePicture,
      'email': email,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
    };
  }

  // Create UserModel from JSON (e.g., when fetching data from Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userName: json['userName'],
      profilePicture: json['profilePicture'],
      email: json['email'],
      isOnline: json['isOnline'],
      lastSeen: json['lastSeen'].toDate(),
    );
  }
}