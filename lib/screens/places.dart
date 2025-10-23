import 'package:faiorites_places/providers/user_places.dart';
import 'package:faiorites_places/screens/add_place.dart';
import 'package:faiorites_places/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPlace()));
            },
            icon: Icon(Icons.add),
          ),
        ],
        title: Text("Your Places"),
      ),
      body: PlaceList(places: userPlaces),
    );
  }
}
