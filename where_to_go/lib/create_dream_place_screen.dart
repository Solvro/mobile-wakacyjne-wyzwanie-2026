import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "features/places/place_model.dart";
import "features/table/dream_place_providers.dart";

class CreateDreamPlaceScreen extends ConsumerStatefulWidget {
  static const route = "/create-place";

  const CreateDreamPlaceScreen({super.key});

  @override
  ConsumerState<CreateDreamPlaceScreen> createState() => _CreateDreamPlaceScreenState();
}

class _CreateDreamPlaceScreenState extends ConsumerState<CreateDreamPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _name = "";
  var _description = "";
  var _isFavorite = false;
  var _imageUrl = "";
  var _loading = false;

  Future<void> _savePlace() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() {
      _loading = true;
    });

    try {
      final dreamPlaceService = ref.read(dreamPlaceServiceProvider);

      final newPlace = PlaceModel(
        id: 0,
        name: _name,
        description: _description,
        isFavorite: _isFavorite,
        imageUrl: "",
        ownerEmail: "",
      );

      final createdPlace = await dreamPlaceService.createDreamPlaceWithPhotoUrl(
        place: newPlace,
        photoUrl: _imageUrl,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Place \"${createdPlace.name}\" created!")),
        );
        Navigator.pop(context, true);
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error creating place: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Dream Place")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (v) => v == null || v.isEmpty ? "Enter a name" : null,
                  onSaved: (v) => _name = v!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (v) => v == null || v.isEmpty ? "Enter a description" : null,
                  onSaved: (v) => _description = v!,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text("Favorite"),
                  value: _isFavorite,
                  onChanged: (val) => setState(() => _isFavorite = val ?? false),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Image URL", hintText: "Enter a direct link to the image"),
                  validator: (v) => v == null || v.isEmpty ? "Enter image URL" : null,
                  onSaved: (v) => _imageUrl = v!,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _savePlace,
                    child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text("Create"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
