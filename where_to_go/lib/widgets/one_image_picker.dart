import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:reactive_forms/reactive_forms.dart";

import "build_image.dart";

class OneImagePicker extends ReactiveFormField<File?, File> {
  final String validationMessage;
  final String? existingImageUrl;

  OneImagePicker({required String formControlname, required this.validationMessage, this.existingImageUrl})
      : super(
            formControlName: formControlname,
            validationMessages: {ValidationMessage.required: (_) => validationMessage},
            builder: (img) {
              final image = img.value;
              return GestureDetector(
                  onTap: () async {
                    final chosenImg = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (chosenImg != null) img.didChange(File(chosenImg.path));
                  },
                  child: SizedBox(
                      height: 200,
                      width: 450,
                      child: BuildImage(
                          hasExistingImage: existingImageUrl != null,
                          selectedImage: image,
                          existingImageUrl: existingImageUrl)));
            });
}
