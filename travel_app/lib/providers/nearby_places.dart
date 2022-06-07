import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/database.dart';

class NearbyPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String name, File image) {
    _places.add(
      Place(
        id: "${name.toString()}_id",
        name: name,
        images: image,
      ),
    );
    notifyListeners();
    DatabaseHelper.insert('user_places', {
      'id': "${name.toString()}_id",
      'title': name,
      'image': image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DatabaseHelper.getData('user_places');
    _places = dataList
        .map((item) => Place(
              id: item['id'],
              name: item['name'],
              images: File(item['image']),
            ))
        .toList();
    notifyListeners();
  }
}
