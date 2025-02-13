class AddServicesModel {
  final String userId;
  final String? userName; // Nullable field
  final String? userImage; // Nullable field
  final String serviceTitle;
  final String? serviceImage; // Nullable field
  final String category;
  final String city;
  final String location;
  final String experience;
  final String price;
  final String description;
  final DateTime timestamp;

  AddServicesModel({
    required this.userId,
    this.userName, // Nullable field
    this.userImage, // Nullable field
    required this.serviceTitle,
    this.serviceImage, // Nullable field
    required this.category,
    required this.city,
    required this.location,
    required this.experience,
    required this.price,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'serviceTitle': serviceTitle,
      'serviceImage': serviceImage,
      'category': category,
      'city': city,
      'location': location,
      'experience': experience,
      'price': price,
      'description': description,
      'timestamp': timestamp,
    };
  }

  factory AddServicesModel.fromMap(Map<String, dynamic> map) {
    return AddServicesModel(
      userId: map['userId'] ?? '', // Default value
      userName: map['userName'], // Nullable field
      userImage: map['userImage'], // Nullable field
      serviceTitle: map['serviceTitle'] ?? '', // Default value
      serviceImage: map['serviceImage'], // Nullable field
      category: map['category'] ?? '', // Default value
      city: map['city'] ?? '', // Default value
      location: map['location'] ?? '', // Default value
      experience: map['experience'] ?? '', // Default value
      price: map['price'] ?? '', // Default value
      description: map['description'] ?? '', // Default value
      timestamp: map['timestamp']?.toDate() ?? DateTime.now(), // Default value
    );
  }
}