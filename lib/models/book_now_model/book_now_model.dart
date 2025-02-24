class BookNowModel {
  final String userId;
  final String serviceTitle;
  final String serviceImage;
  final String category;
  final String city;
  final String location;
  final String experience;
  final String price;
  final String description;
  final DateTime? bookingDate;
  final String detailedDescription;

  BookNowModel({
    required this.userId,
    required this.serviceTitle,
    required this.serviceImage,
    required this.category,
    required this.city,
    required this.location,
    required this.experience,
    required this.price,
    required this.description,
    this.bookingDate,
    required this.detailedDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'serviceTitle': serviceTitle,
      'serviceImage': serviceImage,
      'category': category,
      'city': city,
      'location': location,
      'experience': experience,
      'price': price,
      'description': description,
      'bookingDate': bookingDate?.toIso8601String(),
      'detailedDescription': detailedDescription,
    };
  }

  factory BookNowModel.fromMap(Map<String, dynamic> map) {
    return BookNowModel(
      userId: map['userId'] ?? '',
      serviceTitle: map['serviceTitle'] ?? '',
      serviceImage: map['serviceImage'] ?? '',
      category: map['category'] ?? '',
      city: map['city'] ?? '',
      location: map['location'] ?? '',
      experience: map['experience'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      bookingDate: map['bookingDate'] != null ? DateTime.parse(map['bookingDate']) : null,
      detailedDescription: map['detailedDescription'] ?? '',
    );
  }
}