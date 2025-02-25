import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryButton extends StatelessWidget {
  final Function(File?)? onImageSelected;

  const GalleryButton({super.key, this.onImageSelected});

  Future<void> _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    File selectedImage = File(returnedImage.path);
    onImageSelected?.call(selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImageFromGallery,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xB371ECA7),
          border: Border.all(color: const Color(0xFF14E97B)),
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
              Icons.photo,
              size: 32,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
