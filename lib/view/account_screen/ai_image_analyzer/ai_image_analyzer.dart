// import 'dart:io' show File;
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ImageAnalysisScreen extends StatefulWidget {
//   @override
//   _ImageAnalysisScreenState createState() => _ImageAnalysisScreenState();
// }
//
// class _ImageAnalysisScreenState extends State<ImageAnalysisScreen> {
//   XFile? _imageFile;
//   bool _isLoading = false;
//   List<Map<String, dynamic>> _matchedServices = [];
//   String? _errorMessage;
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = pickedFile;
//         _matchedServices = [];
//         _errorMessage = null;
//       });
//       await _analyzeImage(pickedFile);
//     }
//   }
//
//   Future<void> _analyzeImage(XFile imageFile) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // Step 1: Image को Firebase Storage में upload करें (optional)
//
//       // Step 2: AI से image analyze करवाएं
//       final inputImage = InputImage.fromFilePath(imageFile.path);
//       final imageLabeler = GoogleMlKit.vision.imageLabeler();
//       final labels = await imageLabeler.processImage(inputImage);
//
//       // Step 3: Firebase से categories fetch करें
//       final categoriesSnapshot = await FirebaseFirestore.instance.collection('categories').get();
//       final categories = categoriesSnapshot.docs.map((doc) => doc.data()).toList();
//
//       // Step 4: Labels और categories match करें
//       String? matchedCategoryId;
//       for (final label in labels) {
//         for (final category in categories) {
//           if (category['keywords']?.contains(label.label.toLowerCase()) ?? false) {
//             matchedCategoryId = category['id'];
//             break;
//           }
//         }
//         if (matchedCategoryId != null) break;
//       }
//
//       if (matchedCategoryId != null) {
//         // Step 5: Match होने पर services fetch करें
//         final servicesSnapshot = await FirebaseFirestore.instance
//             .collection('services')
//             .where('categoryId', isEqualTo: matchedCategoryId)
//             .get();
//
//         setState(() {
//           _matchedServices = servicesSnapshot.docs.map((doc) => doc.data()).toList();
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'इस image से match होने वाली कोई category नहीं मिली';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Image Analyzer')),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _pickImage,
//             child: Text('Image Upload करें'),
//           ),
//           if (_isLoading) CircularProgressIndicator(),
//           if (_imageFile != null)
//             Image.file(File(_imageFile!.path), height: 200),
//           if (_errorMessage != null)
//             Text(_errorMessage!, style: TextStyle(color: Colors.red)),
//           if (_matchedServices.isNotEmpty) ...[
//             Text('Available Services:', style: TextStyle(fontSize: 18)),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _matchedServices.length,
//                 itemBuilder: (ctx, index) {
//                   final service = _matchedServices[index];
//                   return ListTile(
//                     title: Text(service['name']),
//                     subtitle: Text(service['description'] ?? ''),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }