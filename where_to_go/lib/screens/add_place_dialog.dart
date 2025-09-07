// lib/screens/add_place_dialog.dart
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:image_picker/image_picker.dart";

import "../models/dream_place.dart";
import "../providers/dream_places_provider.dart";
import "../providers/photos_providers.dart";

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
  var _isUploading = false;
  var _uploadStatus = "";

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

        _showSnackbar("Zdjęcie wybrane");
      }
    } on Exception catch (e) {
      if (mounted) {
        _showSnackbar("Błąd wyboru zdjęcia: $e");
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

        _showSnackbar("Zdjęcie zrobione");
      }
    } on Exception catch (e) {
      if (mounted) {
        _showSnackbar("Błąd aparatu: $e");
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
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

    _showSnackbar("Zdjęcie usunięte");
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
              const Text(
                "Zdjęcie miejsca",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              if (_selectedImage != null)
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            height: 150,
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
              ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo, size: 18),
                label: const Text("Dodaj zdjęcie"),
                onPressed: _isUploading ? null : _showImageSourceDialog,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Ulubione", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Switch(
                    value: _isFavorite,
                    onChanged: _isUploading
                        ? null
                        : (value) {
                            setState(() => _isFavorite = value);
                          },
                  ),
                ],
              ),
              if (_isUploading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 8),
                      Text(
                        _uploadStatus.isNotEmpty ? _uploadStatus : "Uploadowanie zdjęcia...",
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isUploading ? null : () => Navigator.of(context).pop(),
          child: const Text("Anuluj"),
        ),
        ElevatedButton(
          onPressed: _isUploading ? null : _addDreamPlace,
          child: _isUploading
              ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
              : const Text("Dodaj"),
        ),
      ],
    );
  }

  Future<void> _addDreamPlace() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
      _uploadStatus = "Przygotowywanie...";
    });

    try {
      final navigator = Navigator.of(context);
      var finalImageUrl = "https://via.placeholder.com/400x300?text=Brak+zdjecia";

      if (_selectedImage != null) {
        try {
          setState(() => _uploadStatus = "Uploadowanie zdjęcia...");

          final photosRepo = ref.read(photosRepositoryProvider);
          final uploadResponse = await photosRepo.uploadPhoto(_selectedImage!);
          finalImageUrl = uploadResponse.path;

          setState(() => _uploadStatus = "Zdjęcie uploaded!");

          if (mounted) {
            _showSnackbar("Zdjęcie uploaded: ${uploadResponse.filename}");
          }
        } on Exception catch (e) {
          if (mounted) {
            _showSnackbar("Błąd uploadu zdjęcia: $e");
          }
          setState(() => _isUploading = false);
          return;
        }
      }

      setState(() => _uploadStatus = "Dodawanie miejsca...");

      final newPlace = DreamPlace(
        name: _nameController.text,
        description: _descController.text,
        imageUrl: finalImageUrl,
        isFavorite: _isFavorite,
      );

      final repo = ref.read(dreamPlaceRepositoryProvider);
      await repo.addDreamPlace(newPlace);

      if (mounted) {
        _showSnackbar("Dodano: ${newPlace.name}");
        navigator.pop(newPlace);
      }
    } on Exception catch (e) {
      if (mounted) {
        _showSnackbar("Błąd dodawania miejsca: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadStatus = "";
        });
      }
    }
  }
}
