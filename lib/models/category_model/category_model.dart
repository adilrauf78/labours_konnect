import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String category;
  final String imagePath;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.category,
    required this.imagePath,
    required this.createdAt,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(
      id: doc.id,
      category: data['category'] ?? '',
      imagePath: data['image_path'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'category': category,
      'image_path': imagePath,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}