class UserModel {
  final String? userId; // Nullable
  final String? firstName; // Nullable
  final String? lastName; // Nullable
  final String? email; // Nullable
  final String? profileImage; // Nullable

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
  });
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profileImage': profileImage,
    };
  }

  // Create UserModel from JSON (e.g., when fetching data from Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }
}