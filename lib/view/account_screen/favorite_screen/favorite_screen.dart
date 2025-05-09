import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<AddServicesModel>> _favoriteServicesFuture;
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  void initState() {
    super.initState();
    // Fetch favorite services as soon as the screen loads
    _favoriteServicesFuture = serviceController.fetchFavoriteServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Services'),
      ),
      body: FutureBuilder<List<AddServicesModel>>(
        future: _favoriteServicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite services found.'));
          }

          List<AddServicesModel> favoriteServices = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteServices.length,
            itemBuilder: (context, index) {
              var service = favoriteServices[index];
              return ListTile(
                title: Text(service.id),
                subtitle: Text('Service ID: ${service.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
