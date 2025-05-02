import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/view/vendor/vendor_bottom_navigator/vendor_bottom_navigator.dart';

class ServiceController extends GetxController{

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController serviceTitle = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  late  TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxString imagePath = ''.obs;
  //selected category
  RxString selectedCategory = 'Choose Category'.obs;
  void updateSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  //Add Services
  double? latitude;
  double? longitude;
  Future<void> addService() async {
    if (serviceTitle.text.isEmpty) {
      showSnackBar(title: 'Please select an image');
    }else if (selectedCategory.value == 'Choose Category') {
      showSnackBar(title: 'Please Enter Category');
    } else if (cityController.text.isEmpty) {
      showSnackBar(title: 'Please Enter City');
    } else if (locationController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Location');
    } else if (experienceController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Experience');
    } else if (priceController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Price');
    } else if (descriptionController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Description');
    } else {
      try {
        isLoading = true;
        update();
        final userId = _auth.currentUser!.uid;
        final userDetails = await fetchUserDetails(userId);

        final firstName = userDetails?['First Name'] ?? 'Unknown';
        final lastName = userDetails?['Last Name'] ?? 'User';
        final countryCode = userDetails?['Country Code'] ?? 'Unknown';
        final phoneNumber = userDetails?['Phone Number'] ?? 'Unknown';
        final profileImage = userDetails?['profileImage'] ?? '';
        final serviceId = _firestore.collection('services').doc();
        final serviceData = AddServicesModel(
          userId: _auth.currentUser?.uid ?? '',
          userName: '$firstName $lastName',
          userImage: profileImage,
          phoneNumber: '$countryCode $phoneNumber',
          serviceTitle: serviceTitle.text.trim(),
          serviceImage: "",
          category: selectedCategory.value,
          city: cityController.text.trim(),
          location: locationController.text.trim(),
          latitude: latitude,
          longitude: longitude,
          experience: experienceController.text.trim(),
          price: priceController.text.trim(),
          description: descriptionController.text.trim(),
          timestamp: DateTime.now(),
        );
        await _firestore.collection('services').add(serviceData.toMap());
        isLoading = false;
        update();
        Get.offAll(() =>VendorBottomNavigator());
        SuccessSnackBar('Success', 'Service added successfully');
        serviceTitle.clear();
        selectedCategory.value = 'Choose Category';
        cityController.clear();
        locationController.clear();
        experienceController.clear();
        priceController.clear();
        descriptionController.clear();
      } catch (e) {
        ErrorSnackBar('Error', 'Failed to add service: $e');
        isLoading = false;
        update();
      }
    }
  }


  //Fetch AddServices Data
  Future<List<AddServicesModel>> fetchServicesForUser() async {
    try {

      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final querySnapshot = await _firestore
          .collection('services')
          .where('userId', isEqualTo: user.uid)
          .get();

      return querySnapshot.docs.map((doc) {
        return AddServicesModel.fromMap(doc.data() ,doc.id);
      }).toList();
    } catch (e) {
      ErrorSnackBar('Error','Error fetching services for user: $e');
      rethrow;
    }
  }

  //Fetch Services by Category

  Future<List<AddServicesModel>> fetchServicesByCategory(String categoryValue) async {
    try {
      final querySnapshot = await _firestore.collection('services')
          .where('category', isEqualTo: categoryValue)
          .get();

      List<AddServicesModel> services = [];

      for (var doc in querySnapshot.docs) {
        final serviceData = doc.data();
        final userId = serviceData['userId'];


        // Fetch user details dynamically
        final userDetails = await fetchUserDetails(userId);

        final service = AddServicesModel(
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
        );

        services.add(service);
      }

      return services;
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to fetch services: $e');
      rethrow;
    }
  }

  //FetchSpecific user
  Future<List<AddServicesModel>> fetchUserServices(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('services')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      return AddServicesModel.fromMap(doc.data(),doc.id);
    }).toList();
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      return  userDoc.data() ;
    } catch (e) {
      print('Error fetching user details: $e');
    }
    return null;
  }

}