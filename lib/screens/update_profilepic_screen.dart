import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/follow_button.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/storage_methods.dart';
import '../utils/utils.dart';

class UpdateProfilePicScreen extends StatefulWidget {
  const UpdateProfilePicScreen({super.key});

  @override
  State<UpdateProfilePicScreen> createState() => _UpdateProfilePicScreenState();
}

class _UpdateProfilePicScreenState extends State<UpdateProfilePicScreen> {
  Uint8List? _image;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          80.0,
        ),
        child: Column(
          children: [
            IconButton(
              onPressed: selectImage,
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
            FollowButton(
                backgroundColor: Colors.black,
                borderColor: Colors.grey,
                function: () async {
                  String photoUrl = await StorageMethods()
                      .uploadImageToStorage('profilePics', _image!, false);
                },
                text: "Onayla",
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
