import 'package:cloud_firestore/cloud_firestore.dart';

class AddServicesModel {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String serviceTitle;
  final String serviceImage;
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
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.serviceTitle,
    required this.serviceImage,
    required this.category,
    required this.city,
    required this.location,
    required this.experience,
    required this.price,
    required this.description,
    required this.phoneNumber,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
  });

  factory AddServicesModel.fromMap(Map<String, dynamic> data, String id) {
    return AddServicesModel(
      id: id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      serviceTitle: data['serviceTitle'] ?? '',
      serviceImage: data['serviceImage'] ?? '',
      category: data['category'] ?? '',
      city: data['city'] ?? '',
      location: data['location'] ?? '',
      experience: data['experience'] ?? '',
      price: data['price'] ?? '',
      description: data['description'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
    );
  }

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
      'phoneNumber': phoneNumber,
      'timestamp': Timestamp.fromDate(timestamp),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}