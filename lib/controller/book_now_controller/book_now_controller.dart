import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';

class BookNowController extends GetxController {
  bool isLoading = false;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Controllers for description and location
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Variables to store booking details
  AddServicesModel? service;
  DateTime? bookingDate;
  String? bookingTime;

  // Set service details
  void setService(AddServicesModel service) {
    this.service = service;
  }

  // Set booking date and time
  void setBookingDetails(DateTime bookingDate, String bookingTime) {
    this.bookingDate = bookingDate;
    this.bookingTime = bookingTime;
  }

  // Book service
  Future<void> bookService(String userId) async {
    if (service == null) {
      showSnackBar(title: 'Please select a service');
    } else if (bookingDate == null) {
      showSnackBar(title: 'Please select a booking date');
    } else if (bookingTime == null || bookingTime!.isEmpty) {
      showSnackBar(title: 'Please select a booking time');
    } else if (descriptionController.text.isEmpty) {
      showSnackBar(title: 'Please enter a description');
    } else if (locationController.text.isEmpty) {
      showSnackBar(title: 'Please enter a location');
    } else {
      try {
        isLoading = true;
        update(); // Notify listeners

        BookNowModel booking = BookNowModel(
          id: '',
          userId: userId,
          vendorId: service!.userId,
          serviceName: service!.serviceTitle,
          bookingDate: bookingDate!,
          bookingTime: bookingTime!,
          description: descriptionController.text.trim(),
          location: locationController.text.trim(),
          status: 'pending',
        );

        await fireStore.collection('bookings').add(booking.toMap());

        // Clear controllers after booking
        descriptionController.clear();
        locationController.clear();

        isLoading = false;
        update(); // Notify listeners

        SuccessSnackBar('Success','Booking confirmed successfully!');
        Get.back(); // Go back to the previous screen
      } catch (e) {
        isLoading = false;
        update(); // Notify listeners
        ErrorSnackBar('Error', 'Failed to book service: $e');
      }
    }
  }
}