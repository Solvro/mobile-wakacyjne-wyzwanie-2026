// lib/screens/update_place_dialog.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../models/dream_place.dart";
import "../providers/dream_places_provider.dart";

class UpdatePlaceDialog extends ConsumerStatefulWidget {
  final DreamPlace place;

  const UpdatePlaceDialog({super.key, required this.place});

  @override
  ConsumerState<UpdatePlaceDialog> createState() => _UpdatePlaceDialogState();
}

class _UpdatePlaceDialogState extends ConsumerState<UpdatePlaceDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  var _isFavourite = false;
  var _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.place.name);
    _descriptionController = TextEditingController(text: widget.place.description);
    _isFavourite = widget.place.isFavourite ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateDreamPlace() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isUpdating = true);

    try {
      final service = ref.read(dreamPlaceServiceProvider);
      final updatedPlace = widget.place.copyWith(
        name: _nameController.text,
        description: _descriptionController.text,
        isFavourite: _isFavourite,
      );

      await service.updateDreamPlace(place: updatedPlace);

      if (!mounted) return;

      ref.invalidate(dreamPlaceProvider(widget.place.id!));
      ref.invalidate(dreamPlacesProvider);

      Navigator.of(context).pop(true);
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nie udało się zaktualizować miejsca: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edytuj miejsce"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nazwa miejsca"),
                validator: (value) => value == null || value.isEmpty ? "Podaj nazwę" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Opis miejsca"),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? "Podaj opis" : null,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _isFavourite,
                onChanged: (val) => setState(() => _isFavourite = val),
                title: const Text("Ulubione"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isUpdating ? null : () => Navigator.of(context).pop(false),
          child: const Text("Anuluj"),
        ),
        ElevatedButton(
          onPressed: _isUpdating ? null : _updateDreamPlace,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(80, 40),
          ),
          child: _isUpdating
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text("Zapisz"),
        ),
      ],
    );
  }
}
