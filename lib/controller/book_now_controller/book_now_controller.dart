import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';
import 'package:labours_konnect/notification_controller/notification_controller.dart';

class BookNowController extends GetxController {
  bool isLoading = false;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final NotificationController notificationController = Get.put(NotificationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ServiceController serviceController = Get.put(ServiceController());
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
  Future<void> bookService() async {
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
        final userId = _auth.currentUser!.uid;
        final userDetails = await serviceController.fetchUserDetails(userId);
        update();
        final firstName = userDetails?['First Name'] ?? 'Unknown';

        final lastName = userDetails?['Last Name'] ?? 'User';
        final profileImage = userDetails?['profileImage'] ?? '';
        BookNowModel booking = BookNowModel(
          userName: '$firstName $lastName',
          vendorName: service!.userName,
          userImage: profileImage,
          userId: _auth.currentUser?.uid ?? '',
          vendorId: service!.userId,
          serviceName: service!.serviceTitle,
          serviceImage: "",
          bookingDate: bookingDate!,
          bookingTime: bookingTime!,
          description: descriptionController.text.trim(),
          location: locationController.text.trim(),
          price: service!.price ?? "0",
          status: 'Pending',
        );

        await fireStore.collection('bookings').add(booking.toMap());
        descriptionController.clear();
        locationController.clear();

        isLoading = false;
        update();

        SuccessSnackBar('Success','Booking confirmed successfully!');
        await notificationController.sendNotification(
          service!.userId,
          'You have a new booking for ${service!.serviceTitle} by $firstName $lastName.',
        );
        Get.back();

      } catch (e) {
        isLoading = false;
        update();
        ErrorSnackBar('Error', 'Failed to book service: $e');
      }
    }
  }

  // Fetch bookings for the current user
  Future<List<BookNowModel>> fetchBookingsForUser() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }
      final querySnapshot = await fireStore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();
      final bookings = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return BookNowModel(
          userName: data['userName'],
          vendorName: data['vendorName'],
          userImage: data['userImage'],
          userId: data['userId'],
          vendorId: data['vendorId'],
          serviceName: data['serviceName'],
          serviceImage: data['serviceImage'],
          bookingDate: (data['bookingDate'] as Timestamp).toDate(),
          bookingTime: data['bookingTime'],
          price: data['price'],
          description: data['description'],
          location: data['location'],
          status: data['status'],
        );
      }).toList();

      return bookings;
    } catch (e) {
      print('Error fetching bookings: $e');
      throw Exception('Failed to fetch bookings: $e');
    }
  }

  // Fetch bookings for the vendor (current user)
  Future<List<BookNowModel>> fetchBookingsForVendor() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Query Firestore for bookings where the vendorId matches the current user's ID
      final querySnapshot = await fireStore
          .collection('bookings')
          .where('vendorId', isEqualTo: userId)
          .get();

      final bookings = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return BookNowModel(
          userName: data['userName'],
          vendorName: data['vendorName'],
          userImage: data['userImage'],
          userId: data['userId'],
          vendorId: data['vendorId'],
          serviceName: data['serviceName'],
          serviceImage: data['serviceImage'],
          bookingDate: (data['bookingDate'] as Timestamp).toDate(),
          bookingTime: data['bookingTime'],
          price: data['price'],
          description: data['description'],
          location: data['location'],
          status: data['status'],
        );
      }).toList();

      return bookings;
    } catch (e) {
      print('Error fetching vendor bookings: $e');
      throw Exception('Failed to fetch vendor bookings: $e');
    }
  }

  //Cancel Booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await fireStore.collection('bookings').doc(bookingId).update({
        'status': 'Cancelled',
      });

      SuccessSnackBar('Success', 'Booking cancelled successfully!');
      update(); // Notify UI about the update
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to cancel booking: $e');
    }
  }

}