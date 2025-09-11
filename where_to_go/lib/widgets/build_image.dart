import "dart:io";

import "package:flutter/material.dart";

import "../utils/paths.dart";

class BuildImage extends StatelessWidget {
  final String? existingImageUrl;
  final File? selectedImage;
  final bool hasExistingImage;

  const BuildImage({super.key, this.existingImageUrl, this.selectedImage, required this.hasExistingImage});

  @override
  Widget build(BuildContext context) {
    if (selectedImage != null) {
      return ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(selectedImage!, fit: BoxFit.cover));
    } else if (hasExistingImage) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(Paths.photoPath + existingImageUrl!, fit: BoxFit.cover));
    } else {
      return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.add_photo_alternate, size: 40), Text("Dodaj zdjęcie")]);
    }
  }
}
