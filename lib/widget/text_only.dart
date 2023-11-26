import 'package:flutter/material.dart';

class TextOnly extends StatelessWidget {
  const TextOnly({
    Key? key,
    required this.label,
    required this.style
  }) : super(key: key);

  final String label;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style,
    );
  }
}
