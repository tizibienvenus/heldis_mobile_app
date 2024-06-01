import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldInput extends StatefulWidget {
  const FieldInput({
    Key? key,
    required this.title,
    required this.controller,
    this.inputType,
    required this.validator,
    this.maxLines,
    this.minLines,
    this.formatter,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
  }) : super(key: key);

  final String title;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? formatter;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final bool obscureText;

  @override
  State<FieldInput> createState() => _FieldInputState();
}

class _FieldInputState extends State<FieldInput> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      inputFormatters: widget.formatter,
      obscureText: widget.obscureText ? isObscure : false,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.title,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.blue[50],
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
