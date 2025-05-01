import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/models/review_model/review_model.dart';

class ReviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxBool isLoading = false.obs;
  final TextEditingController reviewCommentController = TextEditingController();
  final RxDouble selectedRating = 0.0.obs;

  @override
  void onClose() {
    reviewCommentController.dispose();
    super.onClose();
  }

  // Fetch reviews for a specific service
  Future<void> fetchReviews(String serviceId) async {
    try {
      isLoading(true);
      final snapshot = await _firestore
          .collection('services')
          .doc(serviceId)
          .collection('reviews')
          .orderBy('timestamp', descending: true)
          .get();

      reviews.assignAll(snapshot.docs.map((doc) {
        return ReviewModel.fromMap(doc.data(), doc.id);
      }));
    } catch (e) {
      ErrorSnackBar(
        'Error',
        'Failed to fetch reviews: $e',);
    } finally {
      isLoading(false);
    }
  }

  // Add a new review
  Future<void> addReview({
    required String serviceId,
    required String serviceOwnerId,
  }) async {
    try {
      if (selectedRating.value == 0) {
        showSnackBar(title: 'Please select a rating');
      }

      if (reviewCommentController.text.isEmpty) {
        showSnackBar(title: 'Please write a review');
      }

      isLoading(true);
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in';

      // Get user details
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final userData = userDoc.data();

      final review = ReviewModel(
        id: '',
        serviceId: serviceId,
        reviewerId: user.uid,
        reviewerName: userData?['fullName'] ?? 'Anonymous',
        reviewerImage: userData?['profileImage'],
        rating: selectedRating.value,
        comment: reviewCommentController.text,
        timestamp: DateTime.now(),
      );

      // Add review to service's reviews subcollection
      await _firestore
          .collection('services')
          .doc(serviceId)
          .collection('reviews')
          .add(review.toMap());

      // Update service's average rating
      await _updateServiceRating(serviceId);

      // Clear form
      reviewCommentController.clear();
      selectedRating(0.0);

      Get.back(); // Close review dialog
      SuccessSnackBar(
        'Success',
        'Review added successfully',);
    } catch (e) {
      ErrorSnackBar(
        'Error',
        e.toString(),);
    } finally {
      isLoading(false);
    }
  }

  // Update service's average rating
  Future<void> _updateServiceRating(String serviceId) async {
    final reviewsSnapshot = await _firestore
        .collection('services')
        .doc(serviceId)
        .collection('reviews')
        .get();

    if (reviewsSnapshot.docs.isEmpty) return;

    final totalRating = reviewsSnapshot.docs.fold(
      0.0,
          (sum, doc) => sum + (doc.data()['rating'] as num).toDouble(),
    );

    final averageRating = totalRating / reviewsSnapshot.docs.length;

    await _firestore.collection('services').doc(serviceId).update({
      'rating': averageRating,
      'ratingsCount': reviewsSnapshot.docs.length,
    });
  }
}