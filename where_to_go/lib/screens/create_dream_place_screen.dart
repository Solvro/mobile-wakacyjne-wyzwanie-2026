import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:reactive_forms/reactive_forms.dart";
import "package:reactive_image_picker/reactive_image_picker.dart";

import "../places_providers.dart";

enum FormKeys {
  city,
  country,
  description,
  image,
}

class CreateDreamPlaceScreen extends ConsumerWidget {
  CreateDreamPlaceScreen({super.key});

  final form = fb.group({
    FormKeys.city.name: ["", Validators.required],
    FormKeys.country.name: ["", Validators.required],
    FormKeys.description.name: ["", Validators.required],
    FormKeys.image.name: FormControl<List<SelectedFile>>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodaj nowe miejsce"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildForm(context, ref),
      ),
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref) {
    return CreateDreamPlaceForm(form: form);
  }
}

class CreateDreamPlaceForm extends ConsumerWidget {
  const CreateDreamPlaceForm({
    super.key,
    required this.form,
  });

  final FormGroup form;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveForm(
      formGroup: form,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ReactiveTextField<String>(
              formControlName: FormKeys.city.name,
              decoration: const InputDecoration(labelText: "Miasto"),
              validationMessages: {
                ValidationMessage.required: (_) => "Miasto jest wymagane",
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ReactiveTextField<String>(
              formControlName: FormKeys.country.name,
              decoration: const InputDecoration(labelText: "Kraj"),
              validationMessages: {
                ValidationMessage.required: (_) => "Kraj jest wymagany",
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ReactiveTextField<String>(
              formControlName: FormKeys.description.name,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Opis"),
              validationMessages: {
                ValidationMessage.required: (_) => "Opis jest wymagany",
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ReactiveImagePicker(
              formControlName: FormKeys.image.name,
              decoration: const InputDecoration(labelText: "Obraz", hintText: "Wybierz obraz"),
              modes: const [ImagePickerMode.cameraImage, ImagePickerMode.galleryImage],
              selectedImageBuilder: (file) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: ImageView(image: file),
                );
              },
              inputBuilder: (onPressed) {
                final hasError = form.control(FormKeys.image.name).hasError(ValidationMessage.required) &&
                    form.control(FormKeys.image.name).touched;
                return SizedBox(
                  height: 24,
                  child: TextButton(
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: onPressed,
                    child: Text("Zdjęcie",
                        style: hasError
                            ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                )
                            : Theme.of(context).textTheme.bodyLarge),
                  ),
                );
              },
              editIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.add_photo_alternate_rounded,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text("Zmień", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              deleteIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Usuń",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ],
              ),
              deleteDialogBuilder: (context, file, onConfirm) {
                return showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Usunąć zdjęcie?"),
                    content: const Text("Czy na pewno chcesz usunąć to zdjęcie?"),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text("Anuluj"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onConfirm(file);
                          context.pop();
                        },
                        child: const Text("Usuń"),
                      ),
                    ],
                  ),
                );
              },
              validationMessages: {
                ValidationMessage.required: (_) => "Zdjęcie jest wymagane",
              },
              errorBuilder: (errorCode, error) => {},
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                if (form.valid) {
                  await submitForm(form, context, ref);
                } else {
                  form.markAllAsTouched();
                }
              },
              child: const Text("Dodaj"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> submitForm(FormGroup form, BuildContext context, WidgetRef ref) async {
  final city = form.control(FormKeys.city.name).value as String;
  final country = form.control(FormKeys.country.name).value as String;
  final description = form.control(FormKeys.description.name).value as String;
  final image = form.control(FormKeys.image.name).value as List<SelectedFile>;

  try {
    final repo = ref.read(repositoryProvider);
    await repo.addPlaceFromForm(
      city: city,
      country: country,
      description: description,
      imageFile: image.first.file!,
    );

    log("Created place: $city, $country, $description");

    if (!context.mounted) {
      return;
    }
    ref.invalidate(allPlacesProvider);
    context.pop();
  } on Exception catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to create place: $e")),
    );
  }
}
