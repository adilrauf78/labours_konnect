class AddServicesModel {
  final String userId;
  final String? userName;
  final String? userImage;
  final String serviceTitle;
  final String? serviceImage;
  final String category;
  final String city;
  final String location;
  final String experience;
  final String price;
  final String description;
  final DateTime timestamp;

  AddServicesModel({
    required this.userId,
    this.userName,
    this.userImage,
    required this.serviceTitle,
    this.serviceImage,
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
      userId: map['userId'] ?? '',
      userName: map['userName'],
      userImage: map['userImage'],
      serviceTitle: map['serviceTitle'] ?? '',
      serviceImage: map['serviceImage'],
      category: map['category'] ?? '',
      city: map['city'] ?? '',
      location: map['location'] ?? '',
      experience: map['experience'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      timestamp: map['timestamp']?.toDate() ?? DateTime.now(),
    );
  }
}