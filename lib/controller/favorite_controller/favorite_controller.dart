import 'package:cloud_firestore/cloud_firestore.dart' show FieldPath, FieldValue, FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';

class FavoriteController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ServiceController serviceController = Get.put(ServiceController());
  @override
  void onInit() {
    loadFavoriteServices();
    super.onInit();
  }
  // Add this to your ServiceController class

  final RxList<String> favoriteServiceIds = <String>[].obs;

// Load user's favorite services
  Future<void> loadFavoriteServices() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final favorites = List<String>.from(userDoc.data()?['favoriteServices'] ?? []);
      favoriteServiceIds.value = favorites;
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to load favorites: $e');
    }
  }

// Fetch only favorite services
  Stream<List<AddServicesModel>> fetchFavoriteServices() {
    return _firestore.collection('users').doc(_auth.currentUser?.uid).snapshots().asyncExpand((userDoc) {
      final favoriteIds = List<String>.from(userDoc.data()?['favoriteServices'] ?? []);

      if (favoriteIds.isEmpty) {
        return Stream.value([]); // Return empty stream if no favorites
      }

      // Return a stream of services that updates when either:
      // 1. The user's favorite list changes, or
      // 2. Any of the favorite services change
      return _firestore.collection('services')
          .where(FieldPath.documentId, whereIn: favoriteIds)
          .snapshots()
          .asyncMap((servicesSnapshot) async {
        List<AddServicesModel> favoriteServices = [];

        for (var doc in servicesSnapshot.docs) {
          final serviceData = doc.data();
          final userId = serviceData['userId'];

          // Fetch user details for each service
          final userDetails = await serviceController.fetchUserDetails(userId);

          favoriteServices.add(AddServicesModel(
            id: doc.id,
            userId: userId,
            userName: '${userDetails?['First Name'] ?? 'Unknown'} ${userDetails?['Last Name'] ?? 'User'}',
            phoneNumber: '${userDetails?['Country Code'] ?? 'Unknown'} ${userDetails?['Phone Number'] ?? 'Unknown'}',
            userImage: userDetails?['profileImage'] ?? '',
            serviceTitle: serviceData['serviceTitle'],
            serviceImage: serviceData['serviceImage'],
            category: serviceData['category'],
            city: serviceData['city'],
            location: serviceData['location'],
            latitude: serviceData['latitude'],
            longitude: serviceData['longitude'],
            experience: serviceData['experience'],
            price: serviceData['price'],
            description: serviceData['description'],
            timestamp: serviceData['timestamp'].toDate(),
            favorite: true,
          ));
        }

        return favoriteServices;
      });
    });
  }

// Toggle favorite status for a service
  Future<bool> toggleFavoriteService(String serviceId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      await loadFavoriteServices(); // Refresh favorites list

      bool isFavorite;
      if (favoriteServiceIds.contains(serviceId)) {
        favoriteServiceIds.remove(serviceId);
        isFavorite = false;
      } else {
        favoriteServiceIds.add(serviceId);
        isFavorite = true;
      }

      // Update in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'favoriteServices': favoriteServiceIds
      });

      return isFavorite;
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to toggle favorite: $e');
      rethrow;
    }
  }

}
