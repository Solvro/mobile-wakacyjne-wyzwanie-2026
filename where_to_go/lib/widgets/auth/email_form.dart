import "package:flutter/material.dart";
import "package:reactive_forms/reactive_forms.dart";

class EmailForm extends StatelessWidget {
  final String formControlName;
  final String labelText;
  final String validationMessage;
  final String validationMessageEmail;

  const EmailForm(
      {super.key,
      required this.formControlName,
      required this.labelText,
      required this.validationMessage,
      required this.validationMessageEmail});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: formControlName,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validationMessages: {
        ValidationMessage.required: (_) => validationMessage,
        ValidationMessage.email: (_) => validationMessageEmail
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
