class AddServicesModel {
  final String id; // <-- Added serviceId
  final String userId;
  final String userName;
  final String? userImage;
  final String serviceTitle;
  final String? serviceImage;
  final String category;
  final String city;
  final String location;
  final String experience;
  final String price;
  final String description;
  final String phoneNumber;
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;

  AddServicesModel({
    required this.id, // <-- include here
    required this.userId,
    required this.userName,
    this.userImage,
    required this.serviceTitle,
    this.serviceImage,
    required this.category,
    required this.city,
    required this.location,
    required this.experience,
    required this.price,
    required this.description,
    required this.phoneNumber,
    required this.timestamp,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      'phoneNumber': phoneNumber,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddServicesModel.fromMap(Map<String, dynamic> map, [String? id]) {
    return AddServicesModel(
      id: id ?? '', // <-- get it from doc.id
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'],
      serviceTitle: map['serviceTitle'] ?? '',
      serviceImage: map['serviceImage'],
      category: map['category'] ?? '',
      city: map['city'] ?? '',
      location: map['location'] ?? '',
      experience: map['experience'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      timestamp: map['timestamp']?.toDate() ?? DateTime.now(),
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
    );
  }
}
