import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';

class BookingService {
  bool isLoading = false;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();

  Future<void> bookService({
    required AddServicesModel service,
    required String userId,
    required DateTime bookingDate,
    required String bookingTime,
  }) async {
    // Create a new BookNowModel instance
    BookNowModel booking = BookNowModel(
      id: '',
      userId: userId,
      vendorId: service.userId,
      serviceName: service.serviceTitle,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      description: description.text.trim(),
      location: location.text.trim(),
      status: 'pending',
    );

    // Save the booking to Firestore
    await fireStore.collection('bookings').add(booking.toMap());
  }
}

void onBookNowPressed(AddServicesModel service) async {
  // Assuming you have the userId, bookingDate, and bookingTime
  String userId = 'currentUserId';
  DateTime bookingDate = DateTime.now();
  String bookingTime = '10:00 AM';

  BookingService bookingService = BookingService();
  await bookingService.bookService(
    service: service,
    userId: userId,
    bookingDate: bookingDate,
    bookingTime: bookingTime,
  );

  // Navigate to a confirmation screen or show a success message
}