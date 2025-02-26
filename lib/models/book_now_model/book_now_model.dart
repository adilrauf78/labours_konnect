import 'package:cloud_firestore/cloud_firestore.dart';

class BookNowModel {
  final String id;
  final String userId;
  final String vendorId;
  final String serviceName;
  final DateTime bookingDate;
  final String bookingTime;
  final String status;
  final String description; // Added description field
  final String location; // Added location field

  BookNowModel({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.serviceName,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    required this.description, // Added description field
    required this.location, // Added location field
  });

  // Convert Firestore DocumentSnapshot to Model
  factory BookNowModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BookNowModel(
      id: documentId,
      userId: data['userId'] ?? '',
      vendorId: data['vendorId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      bookingTime: data['bookingTime'] ?? '',
      status: data['status'] ?? 'pending',
      description: data['description'] ?? '', // Added description field
      location: data['location'] ?? '', // Added location field
    );
  }

  // Convert Model to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'vendorId': vendorId,
      'serviceName': serviceName,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'status': status,
      'description': description, // Added description field
      'location': location, // Added location field
    };
  }
}