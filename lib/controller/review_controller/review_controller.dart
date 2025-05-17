import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/models/review_model/review_model.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';

class ReviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ServiceController serviceController = Get.put(ServiceController());
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxDouble averageRating = 0.0.obs;
  final RxInt ratingsCount = 0.obs;
  final RxBool isLoading = false.obs;
  final TextEditingController reviewCommentController = TextEditingController();
  final RxDouble selectedRating = 0.0.obs;

  final RxMap<String, double> _serviceAverageRatings = <String, double>{}.obs;

  Future<double> getAverageRating(String serviceId) async {
    // Return cached rating if available
    if (_serviceAverageRatings.containsKey(serviceId)) {
      return _serviceAverageRatings[serviceId]!;
    }

    // Otherwise fetch from Firestore
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('serviceId', isEqualTo: serviceId)
          .get();

      if (snapshot.docs.isEmpty) {
        _serviceAverageRatings[serviceId] = 0.0;
        return 0.0;
      }

      final ratings = snapshot.docs.map((e) => e['rating'] as num).toList();
      final avg = ratings.reduce((a, b) => a + b) / ratings.length;

      _serviceAverageRatings[serviceId] = avg.toDouble();
      return avg.toDouble();
    } catch (e) {
      return 0.0;
    }
  }
  // Fetch reviews for a specific service
  Future<void> fetchReviews(String serviceId) async {
    try {
      isLoading(true);
      final snapshot = await _firestore
          .collection('reviews')
          .where('serviceId', isEqualTo: serviceId)
          .orderBy('timestamp', descending: true)
          .get();

      reviews.assignAll(snapshot.docs.map((doc) {
        return ReviewModel.fromMap(doc.data(), doc.id);
      }));
      // Calculate average rating after fetching
      calculateAverageRating();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to fetch reviews: $e');
    } finally {
      isLoading(false);
    }
  }
// Calculate average rating from current reviews
  void calculateAverageRating() {
    if (reviews.isEmpty) {
      averageRating.value = 0;
      ratingsCount.value = 0;
      return;
    }

    final total = reviews.fold(0.0, (sum, review) => sum + review.rating);
    averageRating.value = total / reviews.length;
    ratingsCount.value = reviews.length;
  }


  // Add a new review
  Future<void> addReview({
    required String serviceId,
    required String serviceOwnerId,
  }) async {
    try {
      if (selectedRating.value == 0) {
        showSnackBar(title: 'Please select a rating');
        return;
      }

      if (reviewCommentController.text.isEmpty) {
        showSnackBar(title: 'Please write a review');
        return;
      }

      isLoading(true);
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in';

      // Get user details
      final userId = _auth.currentUser!.uid;
      final userDetails = await serviceController.fetchUserDetails(userId);
      final firstName = userDetails?['First Name'] ?? 'Unknown';
      final lastName = userDetails?['Last Name'] ?? 'User';
      final profileImage = userDetails?['profileImage'] ?? '';

      final review = ReviewModel(
        id: '',
        serviceId: serviceId,
        reviewerId: _auth.currentUser?.uid ?? '',
        reviewerName: '$firstName $lastName',
        reviewerImage: profileImage,
        rating: selectedRating.value,
        comment: reviewCommentController.text,
        timestamp: DateTime.now(),
      );

      // Add review to reviews collection
      await _firestore.collection('reviews').add(review.toMap());

      reviews.insert(0, review);
      calculateAverageRating();
      // Update service's average rating
      await updateServiceRating(serviceId);

      // Clear form
      reviewCommentController.clear();
      selectedRating(0.0);

      Get.to(BottomNavigator());
      // Close review dialog
      SuccessSnackBar('Success', 'Review added successfully');
    } catch (e) {
      ErrorSnackBar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update service's average rating
  Future<void> updateServiceRating(String serviceId) async {
    try {
      await _firestore.collection('services').doc(serviceId).update({
        'rating': averageRating.value,
        'ratingsCount': ratingsCount.value,
      });
    } catch (e) {
      throw 'Failed to update service rating: $e';
    }
  }
}