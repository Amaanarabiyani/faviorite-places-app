import 'package:faiorites_places/models/place.dart';
import 'package:faiorites_places/screens/place_detail.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text("No Places Added", style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: places.length,
      itemBuilder: (context, index) {
        final yourPlace = places[index];

        return ListTile(
          subtitle: Text(yourPlace.location.address),
          leading: CircleAvatar(radius: 26, backgroundImage: FileImage(yourPlace.image)),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => PlaceDetail(place: yourPlace)));
          },
          title: Text(
            yourPlace.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        );
      },
    );
  }
}
