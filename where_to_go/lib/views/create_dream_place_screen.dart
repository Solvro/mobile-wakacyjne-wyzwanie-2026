import "dart:io";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:reactive_forms/reactive_forms.dart";

import "../features/places/dream_place_service_provider.dart";
import "../models/place/place_create_without_owner_input_dto.dart";
import "../themes/utils.dart";
import "../utils/error_handler.dart";
import "../widgets/one_image_picker.dart";

class CreateDreamPlaceScreen extends ConsumerStatefulWidget {
  const CreateDreamPlaceScreen({super.key});
  static String route = "/create_place";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateDreamPlaceScreenState();
}

class _CreateDreamPlaceScreenState extends ConsumerState<CreateDreamPlaceScreen> {
  final FormGroup form = FormGroup({
    "name": FormControl<String>(validators: [Validators.required]),
    "description": FormControl<String>(validators: [Validators.required]),
    "isFavorite": FormControl<bool>(value: false),
    "image": FormControl<File>(validators: [Validators.required])
  });

  @override
  Widget build(BuildContext context) {
    ref.listen(dreamPlaceServiceProvider, (previous, next) {
      if (next.hasError) {
        handleError(context, ref, next.error);
      }
    });

    return Scaffold(
        appBar: AppBar(title: const Text("Dodaj miejsce")),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ReactiveForm(
                formGroup: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  OneImagePicker(
                    formControlname: "image",
                    validationMessage: "Zdjęcie wymagane",
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: "name",
                    decoration: const InputDecoration(
                      labelText: "Nazwa",
                      border: OutlineInputBorder(),
                    ),
                    validationMessages: {ValidationMessage.required: (_) => "Nazwa wymagana"},
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: "description",
                    maxLines: 6,
                    minLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Opis",
                      border: OutlineInputBorder(),
                    ),
                    validationMessages: {ValidationMessage.required: (_) => "Opis wymagany"},
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dodaj do ulubionych"),
                      const SizedBox(width: 8),
                      ReactiveCheckbox(
                        formControlName: "isFavorite",
                        focusColor: context.colorScheme.onSurface,
                        activeColor: context.colorScheme.onSurface,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: _submit, child: const Text("Dodaj"))
                ])))));
  }

  Future<void> _submit() async {
    if (form.valid) {
      final name = form.value["name"]! as String;
      final description = form.value["description"]! as String;
      final isFavorite = form.value["isFavorite"]! as bool;
      final file = form.value["image"]! as File;

      await ref.read(dreamPlaceServiceProvider.notifier).createDreamPlaceWithPhoto(
          PlaceCreateWithoutOwnerInputDto(name: name, description: description, isFavourite: isFavorite), file);

      if (mounted) context.pop();
    } else {
      form.markAllAsTouched();
    }
  }
}
