import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';

class BookNowController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var bookings = <BookNowModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBookings();
    super.onInit();
  }

  // Fetch Bookings from Firestore
  void fetchBookings() async {
    try {
      isLoading(true);
      var snapshot = await _firestore.collection('bookings').get();
      bookings.value = snapshot.docs.map((doc) => BookNowModel.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      print("Error fetching bookings: $e");
    } finally {
      isLoading(false);
    }
  }

  // Add a new Booking
  Future<void> addBooking(BookNowModel booking) async {
    try {
      await _firestore.collection('bookings').add(booking.toMap());
      fetchBookings();
    } catch (e) {
      print("Error adding booking: $e");
    }
  }

  // Update Booking Status
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({'status': newStatus});
      fetchBookings();
    } catch (e) {
      print("Error updating booking status: $e");
    }
  }

  // Delete Booking
  Future<void> deleteBooking(String bookingId) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).delete();
      fetchBookings();
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }
}
