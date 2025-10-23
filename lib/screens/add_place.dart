import 'dart:io';

import 'package:faiorites_places/providers/user_places.dart';
import 'package:faiorites_places/widgets/image_input.dart';
import 'package:faiorites_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  TextEditingController titleController = TextEditingController();

  File? _selectedImage;

  void savePlace() {
    final enteredText = titleController.text;

    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredText, _selectedImage!);

    Fluttertoast.showToast(msg: "Item Entered Sucessfully");

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Places")),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              decoration: InputDecoration(
                hint: Text("Add Title", style: TextStyle(color: Colors.white)),
              ),
              controller: titleController,
            ),
            SizedBox(height: 10),
            ImageInput(
              pickImage: (image) {
                _selectedImage = image;
              },
            ),
            SizedBox(height: 10),

            LocationInput(),

            SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: savePlace,
              label: Text("Add Places"),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
