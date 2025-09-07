// lib/screens/add_place_dialog.dart
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:image_picker/image_picker.dart";

import "../models/dream_place.dart";
import "../providers/dream_places_provider.dart";

class AddPlaceDialog extends ConsumerStatefulWidget {
  const AddPlaceDialog({super.key});

  @override
  ConsumerState<AddPlaceDialog> createState() => _AddPlaceDialogState();
}

class _AddPlaceDialogState extends ConsumerState<AddPlaceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  var _isFavorite = false;
  File? _selectedImage;
  final _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Błąd wyboru zdjęcia: $e")),
        );
      }
    }
  }

  Future<void> _takePhotoWithCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Błąd aparatu: $e")),
        );
      }
    }
  }

  Future<void> _showImageSourceDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Wybierz źródło zdjęcia"),
        content: const Text("Skąd chcesz dodać zdjęcie?"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _pickImageFromGallery();
            },
            child: const Text("Galeria"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _takePhotoWithCamera();
            },
            child: const Text("Aparat"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Anuluj"),
          ),
        ],
      ),
    );
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Tytuł i formularz
      title: const Text("Dodaj miejsce marzeń"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nazwa",
                  hintText: "Wenecja",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? "Podaj nazwę" : null,
              ),
              const SizedBox(height: 12),
              // Opis miejsca
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: "Opis",
                  hintText: "Piękne miejsce na ziemi",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? "Podaj opis" : null,
              ),
              const SizedBox(height: 16),

              // Sekcja wyboru zdjęcia
              const Text(
                "Zdjęcie miejsca",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              // Podgląd wybranego zdjęcia
              if (_selectedImage != null)
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 16,
                            child: IconButton(
                              icon: const Icon(Icons.close, size: 16, color: Colors.white),
                              onPressed: _removeSelectedImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Wybrano zdjęcie",
                      style: TextStyle(color: Colors.green[700], fontSize: 12),
                    ),
                  ],
                ),

              const SizedBox(height: 12),

              // Przycisk do wyboru zdjęcia
              ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo, size: 18),
                label: const Text("Dodaj zdjęcie"),
                onPressed: _showImageSourceDialog,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),

              const SizedBox(height: 16),
              // Przełącznik ulubionych
              Row(
                children: [
                  const Text("Ulubione", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() => _isFavorite = value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Anuluj i Dodaj
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Anuluj"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            final navigator = Navigator.of(context);

            // Tymczasowo placeholder jeśli nie ma uploadu
            final finalImageUrl = _selectedImage != null
                ? "https://via.placeholder.com/400x300?text=Wybrales+zdjecie"
                : "https://via.placeholder.com/400x300?text=Brak+zdjecia";

            final newPlace = DreamPlace(
              name: _nameController.text,
              description: _descController.text,
              imageUrl: finalImageUrl,
              isFavorite: _isFavorite,
            );

            final repo = ref.read(dreamPlaceRepositoryProvider);
            await repo.addDreamPlace(newPlace);

            if (mounted) {
              navigator.pop(newPlace);
            }
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }
}
