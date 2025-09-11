import "dart:io";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:reactive_forms/reactive_forms.dart";

import "../features/places/dream_place_service_provider.dart";
import "../models/place/place_create_without_owner_input_dto.dart";
import "../models/place/place_response_dto.dart";
import "../themes/utils.dart";
import "../utils/error_handler.dart";
import "../widgets/one_image_picker.dart";

class CreateDreamPlaceScreen extends ConsumerStatefulWidget {
  static String route = "/create_place";
  final PlaceResponseDto? existingPlace;

  const CreateDreamPlaceScreen({super.key, this.existingPlace});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateDreamPlaceScreenState();
}

class _CreateDreamPlaceScreenState extends ConsumerState<CreateDreamPlaceScreen> {
  late final FormGroup form;
  bool get isEditing => widget.existingPlace != null;

  @override
  void initState() {
    super.initState();
    _initalizeForm();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(dreamPlaceServiceProvider, (previous, next) {
      if (next.hasError) {
        handleError(context, ref, next.error);
      }
    });

    return Scaffold(
        appBar: AppBar(title: isEditing ? const Text("Edytuj miejsce") : const Text("Dodaj miejsce")),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ReactiveForm(
                formGroup: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  OneImagePicker(
                    formControlname: "image",
                    validationMessage: "Zdjęcie wymagane",
                    existingImageUrl: widget.existingPlace?.imageUrl,
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
                  ElevatedButton(onPressed: _submit, child: isEditing ? const Text("Aktualizuj") : const Text("Dodaj"))
                ])))));
  }

  Future<void> _submit() async {
    if (form.valid) {
      final name = form.value["name"]! as String;
      final description = form.value["description"]! as String;
      final isFavorite = form.value["isFavorite"]! as bool;
      final file = form.value["image"] as File?;

      if (isEditing) {
        final id = widget.existingPlace!.id.toString();
        await ref.read(dreamPlaceServiceProvider.notifier).updatePlace(
            id,
            PlaceCreateWithoutOwnerInputDto(
                name: name,
                description: description,
                isFavourite: isFavorite,
                imageUrl: widget.existingPlace!.imageUrl),
            file);
      } else {
        await ref.read(dreamPlaceServiceProvider.notifier).createDreamPlaceWithPhoto(
            PlaceCreateWithoutOwnerInputDto(name: name, description: description, isFavourite: isFavorite), file!);
      }

      if (mounted) context.pop();
    } else {
      form.markAllAsTouched();
    }
  }

  void _initalizeForm() {
    form = FormGroup({
      "name": FormControl<String>(value: widget.existingPlace?.name, validators: [Validators.required]),
      "description": FormControl<String>(value: widget.existingPlace?.description, validators: [Validators.required]),
      "isFavorite": FormControl<bool>(value: widget.existingPlace?.isFavourite ?? false),
      "image": FormControl<File>()
    });

    if (!isEditing) {
      form.control("image").setValidators([Validators.required]);
    }
  }
}
