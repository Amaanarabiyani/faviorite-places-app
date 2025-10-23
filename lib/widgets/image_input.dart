// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.pickImage});

  final Function(File image) pickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    setState(() {
      selectedImage = File(pickedImage.path);
    });

    Navigator.pop(context);

    widget.pickImage(selectedImage!);
  }

  void takeGallery() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);

    if (pickedImage == null) return;

    setState(() {
      selectedImage = File(pickedImage.path);
    });

    Navigator.pop(context);

    widget.pickImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: selectedImage == null
          ? TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton.icon(
                                onPressed: takePicture,
                                label: Text("Camera"),
                                icon: Icon(Icons.camera),
                              ),

                              TextButton.icon(
                                onPressed: takeGallery,
                                label: Text("Gallery"),
                                icon: Icon(Icons.browse_gallery),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              label: Text("Take Picture"),
              icon: Icon(Icons.camera),
            )
          : GestureDetector(
              child: Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity),
              onTap: () {
                setState(() {
                  selectedImage = null;
                });
              },
            ),
    );
  }
}
