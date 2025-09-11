// lib/screens/add_place_dialog.dart
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:image_picker/image_picker.dart";

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
  var _isUploading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Wybór zdjęcia z aparatu lub galerii
  Future<void> _pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Wybierz źródło zdjęcia"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, ImageSource.gallery),
            child: const Text("Galeria"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ImageSource.camera),
            child: const Text("Aparat"),
          ),
        ],
      ),
    );

    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    }
  }

  // Dodanie miejsca poprzez przekazanie do dreamPlaceServiceProvider gdzie jest createDreamPlaceWithPhoto
  Future<void> _addDreamPlace() async {
    if (!_formKey.currentState!.validate() || _selectedImage == null) return;

    setState(() => _isUploading = true);

    try {
      final service = ref.read(dreamPlaceServiceProvider);

      final newPlace = await service.createDreamPlaceWithPhoto(
        file: _selectedImage!,
        name: _nameController.text,
        description: _descController.text,
        isFavourite: _isFavorite,
      );

      if (mounted) {
        Navigator.of(context).pop(newPlace);
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Błąd: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Dodaj miejsce marzeń"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nazwa"),
                validator: (value) => value == null || value.isEmpty ? "Podaj nazwę" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Opis"),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? "Podaj opis" : null,
              ),
              const SizedBox(height: 12),
              if (_selectedImage != null) Image.file(_selectedImage!, height: 120, fit: BoxFit.cover),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Dodaj zdjęcie"),
              ),
              SwitchListTile(
                value: _isFavorite,
                onChanged: (val) => setState(() => _isFavorite = val),
                title: const Text("Ulubione"),
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
          child: _isUploading ? const CircularProgressIndicator() : const Text("Dodaj"),
        ),
      ],
    );
  }
}
