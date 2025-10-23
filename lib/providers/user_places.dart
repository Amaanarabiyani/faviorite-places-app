import 'dart:io';

import 'package:faiorites_places/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = StateNotifierProvider((ref) => UserPlacesNotifier());
