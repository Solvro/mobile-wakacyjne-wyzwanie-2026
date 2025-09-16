import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "dreamplace.dart";
import "dreamplace_providers.dart";

class CreateDreamPlaceScreen extends ConsumerStatefulWidget {
  const CreateDreamPlaceScreen({super.key});

  @override
  ConsumerState<CreateDreamPlaceScreen> createState() =>
      _CreateDreamPlaceScreenState();
}

class _CreateDreamPlaceScreenState
    extends ConsumerState<CreateDreamPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();

  var _saving = false;

  @override
  void dispose() {
    _nameCtrl
      ..removeListener(() {})
      ..dispose();
    _descCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      final place = DreamPlace(
        id: "", 
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text,
        assetPath: _imageCtrl.text.trim(),
      );

      await ref.read(dreamPlacesControllerProvider.notifier).add(place);

      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Miejsce utworzone")),
      );
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Błąd tworzenia: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dodaj miejsce")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: "Nazwa *"),
                textInputAction: TextInputAction.next,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Podaj nazwę" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: "Opis"),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageCtrl,
                decoration: const InputDecoration(
                  labelText: "Image URL (opcjonalnie)",
                  hintText: "https://…/photo.jpg",
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _saving ? null : _submit,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
                label: const Text("Utwórz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
