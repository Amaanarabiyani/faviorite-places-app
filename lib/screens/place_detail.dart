import 'package:faiorites_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetail extends StatelessWidget {
  const PlaceDetail({super.key, required this.place});

  final Place place;

  String getUserLocationImage(double lat, double lng) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyCPMgv3duvS967kagdXKvcn0eD72L3sdF4";
  }

  // String get locationImage {
  //   final lat = place.location.latitude;
  //   final lng = place.location.longitude;
  //   return "https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyCPMgv3duvS967kagdXKvcn0eD72L3sdF4";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(place.image, fit: BoxFit.cover, height: double.infinity),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    getUserLocationImage(place.location.latitude, place.location.longitude),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.transparent, Colors.black54]),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
