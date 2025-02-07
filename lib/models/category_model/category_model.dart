import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String category;
  final String imagePath;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.category,
    required this.imagePath,
    required this.createdAt,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: doc.id,
      category: data['category'] ?? '',
      imagePath: data['image_path'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }
}