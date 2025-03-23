import 'package:cloud_firestore/cloud_firestore.dart';

class BookNowModel {
  final String bookingId; // Ensure this field exists
  final String userName;
  final String userImage;
  final String userId;
  final String vendorId;
  final String vendorName;
  final String serviceName;
  final String serviceImage;
  final DateTime bookingDate;
  final String bookingTime;
  final String status;
  final String description;
  final String location;
  final String price;

  BookNowModel({
    required this.bookingId, // Make bookingId required
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.vendorId,
    required this.vendorName,
    required this.serviceName,
    required this.serviceImage,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    required this.description,
    required this.location,
    required this.price,
  });

  // Convert Firestore DocumentSnapshot to Model
  factory BookNowModel.fromMap(Map<String, dynamic> data, String bookingId) {
    return BookNowModel(
      bookingId: bookingId, // Assign the bookingId
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      userId: data['userId'] ?? '',
      vendorId: data['vendorId'] ?? '',
      vendorName: data['vendorName'] ?? '',
      serviceName: data['serviceName'] ?? '',
      serviceImage: data['serviceImage'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      bookingTime: data['bookingTime'] ?? '',
      status: data['status'] ?? 'pending',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      price: data['price'] ?? '',
    );
  }

  // Convert Model to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImage': userImage,
      'userId': userId,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'serviceName': serviceName,
      'serviceImage': serviceImage,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'bookingTime': bookingTime,
      'status': status,
      'description': description,
      'location': location,
      'price': price,
    };
  }
}