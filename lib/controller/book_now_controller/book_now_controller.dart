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
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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
        final countryCode = userDetails?['Country Code'] ?? 'Unknown';
        final phoneNumber = userDetails?['Phone Number'] ?? 'Unknown';
        final profileImage = userDetails?['profileImage'] ?? '';
        final bookingRef = fireStore.collection('bookings').doc();
        BookNowModel booking = BookNowModel(
          bookingId: bookingRef.id,
          userName: '$firstName $lastName',
          phoneNumber: '$countryCode $phoneNumber',
          vendorName: service!.userName,
          userImage: profileImage,
          userId: _auth.currentUser?.uid ?? '',
          vendorId: service!.userId,
          serviceId: service!.id,
          serviceName: service!.serviceTitle,
          serviceImage: "",
          bookingDate: bookingDate!,
          bookingTime: bookingTime!,
          description: descriptionController.text.trim(),
          location: locationController.text.trim(),
          price: service!.price ?? "0",
          status: 'Pending',
        );

        await bookingRef.set(booking.toMap());
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
        //ErrorSnackBar('Error', 'Failed to book service: $e');
      }
    }
  }

  // Fetch bookings for the current user
  Stream<List<BookNowModel>> fetchBookingsForUser() {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }
      return fireStore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('bookingDate', descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return BookNowModel(
          bookingId: doc.id,
          userName: data['userName'],
          phoneNumber: data['phoneNumber'],
          vendorName: data['vendorName'],
          userImage: data['userImage'],
          userId: data['userId'],
          vendorId: data['vendorId'],
          serviceId: data['serviceId'],
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
      });
  }

  // Fetch bookings for the vendor (current user)
  Stream<List<BookNowModel>> fetchBookingsForVendor()  {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }
      return fireStore
          .collection('bookings')
          .where('vendorId', isEqualTo: userId)
          .orderBy('bookingDate', descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return BookNowModel.fromMap(data, doc.id);
      }).toList();
      });
  }

  //Cancel Booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await fireStore.collection('bookings').doc(bookingId).update({
        'status': 'Cancelled',
      });

      SuccessSnackBar('Success', 'Booking cancelled successfully!');
      update();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to cancel booking: $e');
    }
  }
// Accept a booking
  Future<void> acceptBooking(String bookingId) async {
    try {
      await fireStore.collection('bookings').doc(bookingId).update({
        'status': 'Accepted',
      });

      SuccessSnackBar('Success', 'Booking accepted successfully!');
      update();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to accept booking: $e');
    }
  }

// Mark a booking as On Going
  Future<void> OnGoingBooking(String bookingId) async {
    try {
      await fireStore.collection('bookings').doc(bookingId).update({
        'status': 'On Going',
      });

      SuccessSnackBar('Success', 'Booking marked as On Going!');
      update();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to update booking status: $e');
    }
  }

  // In Progress a booking
  Future<void> InProgressBooking(String bookingId) async {
    try {
      await fireStore.collection('bookings').doc(bookingId).update({
        'status': 'In Progress',
      });

      SuccessSnackBar('Success', 'Booking In progress successfully!');
      update();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to update booking status: $e');
    }
  }

// Mark a booking as Completed
  Future<void> markBookingAsCompleted(String bookingId) async {
    try {
      await fireStore.collection('bookings').doc(bookingId).update({
        'status': 'Completed',
      });

      SuccessSnackBar('Success', 'Booking marked as Completed!');
      update();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to complete booking: $e');
    }
  }
}