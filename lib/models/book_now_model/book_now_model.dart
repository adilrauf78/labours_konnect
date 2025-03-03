import 'package:cloud_firestore/cloud_firestore.dart';

class BookNowModel {
  final String userName; // Added userName field
  final String userImage; // Added userImage field
  final String userId;
  final String vendorId;
  final String serviceName;
  final String serviceImage; // Added serviceImage field
  final DateTime bookingDate;
  final String bookingTime;
  final String status;
  final String description;
  final String location;

  BookNowModel({
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.vendorId,
    required this.serviceName,
    required this.serviceImage,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    required this.description,
    required this.location,
  });

  // Convert Firestore DocumentSnapshot to Model
  factory BookNowModel.fromMap(Map<String, dynamic> data) {
    return BookNowModel(
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      userId: data['userId'] ?? '',
      vendorId: data['vendorId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      serviceImage: data['serviceImage'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      bookingTime: data['bookingTime'] ?? '',
      status: data['status'] ?? 'pending',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
    );
  }

  // Convert Model to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImage': userImage,
      'userId': userId,
      'vendorId': vendorId,
      'serviceName': serviceName,
      'serviceImage': serviceImage,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'status': status,
      'description': description,
      'location': location,
    };
  }
}