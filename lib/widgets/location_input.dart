import 'dart:convert';
import 'dart:developer';

import 'package:faiorites_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickLocation;
  var isGettingLocation = false;

  String get locationImage {
    if (_pickLocation == null) {
      return "";
    }

    final lat = _pickLocation!.latitude;
    final lng = _pickLocation!.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyCPMgv3duvS967kagdXKvcn0eD72L3sdF4";
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // setState(() {
    //   isGettingLocation = true;
    // });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final uri = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCPMgv3duvS967kagdXKvcn0eD72L3sdF4",
    );

    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      isGettingLocation = false;
      _pickLocation = PlaceLocation(latitude: lat, longitude: lng, address: address);
    });
    log(locationData.longitude.toString());
    log(locationData.latitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pickLocation != null
            ? Image.network(locationImage, fit: BoxFit.cover, width: double.infinity)
            : Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: isGettingLocation
                    ? CircularProgressIndicator()
                    : Text(
                        "No Location Chosen",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
              ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              label: Text("Get Current Location"),
              icon: Icon(Icons.location_on),
            ),
            TextButton.icon(onPressed: () {}, label: Text("Select On Map"), icon: Icon(Icons.map)),
          ],
        ),
      ],
    );
  }
}
