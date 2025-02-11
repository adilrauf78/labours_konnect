import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labours_konnect/models/category_model/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var categories = <CategoryModel>[].obs;
  TextEditingController searchController = TextEditingController();
  var filteredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchCategory(searchController.text);
    });
    fetchCategories();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }



  void searchCategory(String query) {
    query = query.toLowerCase();
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      filteredCategories.assignAll(
        categories.where((category) =>
            category.category.toLowerCase().contains(query)).toList(),
      );
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot = await fireStore.collection('categories').get();
      return querySnapshot.docs.map((doc) => CategoryModel.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }


}
