import "dart:io";

import "package:flutter/material.dart";
import "package:reactive_forms/reactive_forms.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../../../data/models/dream_place.dart";
import "../../common/widgets/error_snack_bar.dart";
import "../../common/widgets/reactive_image_picker.dart";

class CreatePlaceView extends StatefulWidget {
  final void Function(Map<String, Object?> values) onSubmit;
  final DreamPlace? place;
  const CreatePlaceView({super.key, required this.onSubmit, this.place});

  @override
  State<CreatePlaceView> createState() => _CreatePlaceViewState();
}

class _CreatePlaceViewState extends State<CreatePlaceView> {
  late FormGroup form = FormGroup({
    "name": FormControl<String>(validators: [Validators.required], value: widget.place?.name),
    "description": FormControl<String>(validators: [Validators.required], value: widget.place?.description),
    "isFavourite": FormControl<bool>(value: widget.place?.isFavourite ?? false),
    "image": FormControl<File>(
      validators: [Validators.required],
    ),
  });

  void _submit() {
    if (form.valid) {
      widget.onSubmit(form.value);
      form.reset();
    } else {
      form.markAllAsTouched();
      context.showErrorSnackBar("Please correct the errors");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Dream Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPaddings.large),
        child: ReactiveForm(
          formGroup: form,
          child: ListView(
            children: [
              ReactiveTextField<String>(
                formControlName: "name",
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) => "Name is required",
                },
              ),
              const SizedBox(
                height: CreatePlaceViewConfig.fieldGap,
              ),
              ReactiveTextField<String>(
                formControlName: "description",
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validationMessages: {
                  ValidationMessage.required: (_) => "Description is required",
                },
              ),
              const SizedBox(
                height: CreatePlaceViewConfig.fieldGap,
              ),
              ReactiveCheckboxListTile(
                formControlName: "isFavourite",
                title: const Text("Mark as Favourite"),
              ),
              const SizedBox(
                height: CreatePlaceViewConfig.fieldGap,
              ),
              ReactiveImagePicker(
                formControlName: "image",
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.onSurface),
                  borderRadius: BorderRadius.circular(CreatePlaceViewConfig.radius),
                ),
                errorTextStyle: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.error),
              ),
              const SizedBox(
                height: CreatePlaceViewConfig.fieldGap,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.place != null ? "Update Place" : "Create Place"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
