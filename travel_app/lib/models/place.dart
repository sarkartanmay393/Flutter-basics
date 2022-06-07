import 'dart:io';

import 'package:flutter/material.dart';

class Place {
  final String id;
  final String name;
  //late Location location;
  final File images;

  Place({
    required this.id,
    required this.name,
   // this.location,
    required this.images,
  });
}

class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}
