import "dart:io";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:image_picker/image_picker.dart";
import "../features/photos/dream_place_service_provider.dart";
import "features/database/dream_place_provider.dart";
import "features/models/dream_place.dart";

class CreateDreamPlaceScreen extends ConsumerStatefulWidget {
  final DreamPlace? dreamPlace;

  const CreateDreamPlaceScreen({super.key, this.dreamPlace});

  @override
  ConsumerState<CreateDreamPlaceScreen> createState() => _CreateDreamPlaceScreenState();
}

class _CreateDreamPlaceScreenState extends ConsumerState<CreateDreamPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _selectedImage;
  var _isLoading = false;

  bool get isEditMode => widget.dreamPlace != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _nameController.text = widget.dreamPlace!.name;
      _descriptionController.text = widget.dreamPlace!.description;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!isEditMode && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wybierz zdjęcie")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final service = ref.read(dreamPlaceServiceProvider);

      if (isEditMode) {
        await service.updateDreamPlaceWithPhoto(
          id: widget.dreamPlace!.id!,
          name: _nameController.text,
          description: _descriptionController.text,
          photo: _selectedImage != null ? File(_selectedImage!.path) : null,
          currentImageUrl: widget.dreamPlace!.imageUrl,
          isFavourite: widget.dreamPlace!.isFavourite,
        );

        ref.invalidate(dreamPlacesProvider);

        if (!mounted) return;
        GoRouter.of(context).go("/");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Miejsce zaktualizowane")),
        );
      } else {
        await service.createDreamPlaceWithPhoto(
          name: _nameController.text,
          description: _descriptionController.text,
          photo: File(_selectedImage!.path),
        );

        ref.invalidate(dreamPlacesProvider);

        if (!mounted) return;
        GoRouter.of(context).go("/");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Miejsce dodane")),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Błąd: ${e.message}")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edytuj miejsce" : "Dodaj nowe miejsce"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _isLoading ? null : _submitForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Nazwa miejsca",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Podaj nazwę" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Opis",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) => value == null || value.isEmpty ? "Podaj opis" : null,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _selectedImage != null
                            ? Image.file(File(_selectedImage!.path), fit: BoxFit.cover)
                            : (isEditMode
                                ? Image.network("https://backend-api.w.solvro.pl/photos/${widget.dreamPlace!.imageUrl}",
                                    fit: BoxFit.cover)
                                : const Center(child: Icon(Icons.add_photo_alternate, size: 50))),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      child: Text(isEditMode ? "Zapisz zmiany" : "Dodaj miejsce"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
