import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String? id;
  String imageUrl;
  String title;
  String category;
  String price;
  String location;
  String description;
  String experience;
  String city;
  DateTime? timestamp;

  ServiceModel({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
    required this.location,
    required this.description,
    required this.experience, // New field
    required this.city, // New field
    this.timestamp,
  });

  // Firestore se data ko Dart object mein convert karein
  factory ServiceModel.fromMap(Map<String, dynamic> data, String id) {
    return ServiceModel(
      id: id,
      imageUrl: data['imageUrl'],
      title: data['title'],
      category: data['category'],
      price: data['price'],
      location: data['location'],
      description: data['description'],
      experience: data['experience'],
      city: data['city'],
      timestamp: data['timestamp']?.toDate(),
    );
  }

}