import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Place {
  Place(this.image, {required this.title, this.location}) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation? location;
}

class PlaceLocation {
  PlaceLocation({required this.latitude, required this.longitude, required this.address});

  final double latitude;
  final double longitude;
  final String address;
}
