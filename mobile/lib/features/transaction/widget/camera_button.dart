import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatelessWidget {
  final Function(File?)? onImageCaptured;

  const CameraButton({super.key, required this.onImageCaptured});

  Future<void> _takePicture() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    File selectedImage = File(returnedImage.path);
    onImageCaptured?.call(selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _takePicture,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xB371ECA7),
          border: Border.all(color: Color(0xFF14E97B)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Container(
            width: 60,
            height: 50,
            decoration: const BoxDecoration(
              color:  Color(0xB371ECA7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              size: 32,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

