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

class CreateOrEditDreamPlaceScreen extends ConsumerWidget {
  final int? editId;
  const CreateOrEditDreamPlaceScreen({super.key, this.editId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existingPlace = editId != null ? ref.read(placeDetailsProvider(editId!)).value : null;
    final city = existingPlace?.name.split(RegExp(r",\s*")).first;
    final country = existingPlace?.name.split(RegExp(r",\s*")).last;
    final form = fb.group({
      FormKeys.city.name: [city ?? "", Validators.required],
      FormKeys.country.name: [country ?? "", Validators.required],
      FormKeys.description.name: [existingPlace?.description ?? "", Validators.required],
      FormKeys.image.name:
          FormControl<List<SelectedFile>>(validators: existingPlace == null ? [Validators.required] : []),
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(editId != null ? "Edytuj miejsce" : "Dodaj nowe miejsce"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildForm(context, ref, form),
      ),
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref, FormGroup form) {
    return CreateDreamPlaceForm(form: form, editId: editId);
  }
}

class CreateDreamPlaceForm extends ConsumerWidget {
  const CreateDreamPlaceForm({super.key, required this.form, this.editId});

  final FormGroup form;
  final int? editId;

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
              decoration: const InputDecoration(labelText: "Miasto", hintText: "Wpisz nazwę miasta..."),
              validationMessages: {
                ValidationMessage.required: (_) => "Miasto jest wymagane",
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ReactiveTextField<String>(
              formControlName: FormKeys.country.name,
              decoration: const InputDecoration(labelText: "Kraj", hintText: "Wpisz nazwęę kraju..."),
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
              decoration: const InputDecoration(labelText: "Opis", hintText: "Wpisz opis miejsca..."),
              validationMessages: {
                ValidationMessage.required: (_) => "Opis jest wymagany",
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ReactiveImagePicker(
              formControlName: FormKeys.image.name,
              decoration: const InputDecoration(labelText: "Zdjęcie"),
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
                  height: editId != null ? 48 : 24,
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: onPressed,
                    child: Text(
                        editId != null
                            ? "Dotknij, aby wybrać nowe zdjęcie \n(pozostaw puste, aby nie zmieniać)"
                            : "Dotknij, aby wybrać zdjęcie",
                        style: hasError
                            ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                )
                            : Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey,
                                )),
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
                  await submitForm(form, context, ref, editId);
                } else {
                  form.markAllAsTouched();
                }
              },
              child: Text(editId != null ? "Zapisz" : "Dodaj"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> submitForm(FormGroup form, BuildContext context, WidgetRef ref, int? editId) async {
  final city = form.control(FormKeys.city.name).value as String;
  final country = form.control(FormKeys.country.name).value as String;
  final description = form.control(FormKeys.description.name).value as String;
  final image = form.control(FormKeys.image.name).value as List<SelectedFile>;

  try {
    final repo = ref.read(repositoryProvider);

    if (editId != null) {
      await repo.updatePlaceFromForm(
        id: editId,
        city: city,
        country: country,
        description: description,
        imageFile: image.isNotEmpty ? image.first.file! : null,
      );

      log("Updated place: $city, $country, $description");

      if (!context.mounted) {
        return;
      }
      ref.invalidate(placeDetailsProvider(editId));
      ref.invalidate(allPlacesProvider);
      context.pop();
      return;
    }
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
