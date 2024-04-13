import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  const FieldInput({
    Key? key,
    required this.title,
    required this.controller,
    this.inputType,
    required this.validator,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType? inputType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: title,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      validator: validator,
    );
  }
}
