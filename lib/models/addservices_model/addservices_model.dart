class AddServicesModel {
  final String userId;
  final String imageUrl;
  final String serviceTitle;
  final String category;
  final String city;
  final String location;
  final String experience;
  final String price;
  final String description;
  final DateTime timestamp;

  AddServicesModel({
    required this.userId,
    required this.imageUrl,
    required this.serviceTitle,
    required this.category,
    required this.city,
    required this.location,
    required this.experience,
    required this.price,
    required this.description,
    required this.timestamp,
  });

  // Convert the model to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'serviceTitle': serviceTitle,
      'category': category,
      'city': city,
      'location': location,
      'experience': experience,
      'price': price,
      'description': description,
      'timestamp': timestamp,
    };
  }

  // Create a model from a Firestore document
  factory AddServicesModel.fromMap(Map<String, dynamic> map) {
    return AddServicesModel(
      userId: map['userId'] ?? '', // Provide a default value if null
      imageUrl: map['imageUrl'] ?? '',
      serviceTitle: map['serviceTitle'] ?? '',
      category: map['category'] ?? '',
      city: map['city'] ?? '',
      location: map['location'] ?? '',
      experience: map['experience'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      timestamp: map['timestamp']?.toDate() ?? DateTime.now(), // Handle null timestamp
    );
  }
}