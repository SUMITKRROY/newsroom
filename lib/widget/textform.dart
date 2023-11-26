import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscured;
  final dynamic suffixIcon;

  const CustomTextField(
      {super.key,
        required this.label,
        this.inputFormatters,
        this.validator,
        this.initialValue,
        required this.onChanged,
        this.controller,
        this.obscured = false,
        this.suffixIcon, this.keyboardType});

  @override
  @override
  State<CustomTextField> createState() {
    return _CustomTextField();
  }
}

class _CustomTextField extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      controller: widget.controller ?? _controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: widget.suffixIcon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: widget.label,
          fillColor: Colors.white,
          filled: true),
      obscureText: widget.obscured,
    );
  }
}
