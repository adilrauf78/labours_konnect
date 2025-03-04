import 'package:cloud_firestore/cloud_firestore.dart';

class BookNowModel {
  final String userName;
  final String userImage;
  final String userId;
  final String vendorId;
  final String vendorName; // Added vendorName field
  final String serviceName;
  final String serviceImage;
  final DateTime bookingDate;
  final String bookingTime;
  final String status;
  final String description;
  final String location;
  final double price; // Added price field

  BookNowModel({
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.vendorId,
    required this.vendorName, // Added to constructor
    required this.serviceName,
    required this.serviceImage,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    required this.description,
    required this.location,
    required this.price, // Added to constructor
  });

  // Convert Firestore DocumentSnapshot to Model
  factory BookNowModel.fromMap(Map<String, dynamic> data) {
    return BookNowModel(
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      userId: data['userId'] ?? '',
      vendorId: data['vendorId'] ?? '',
      vendorName: data['vendorName'] ?? '', // Fetch vendorName from Firestore
      serviceName: data['serviceName'] ?? '',
      serviceImage: data['serviceImage'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      bookingTime: data['bookingTime'] ?? '',
      status: data['status'] ?? 'pending',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0, // Fetch price from Firestore
    );
  }

  // Convert Model to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImage': userImage,
      'userId': userId,
      'vendorId': vendorId,
      'vendorName': vendorName, // Include vendorName in Firestore document
      'serviceName': serviceName,
      'serviceImage': serviceImage,
      'bookingDate': Timestamp.fromDate(bookingDate), // Convert DateTime to Timestamp
      'bookingTime': bookingTime,
      'status': status,
      'description': description,
      'location': location,
      'price': price, // Include price in Firestore document
    };
  }
}