import 'package:flutter/material.dart';

class Hyperlink extends StatelessWidget {
  const Hyperlink({super.key, required this.title, required this.onPressed});

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w900,
            decorationColor: Theme.of(context).colorScheme.primary,
          ),
        ));
  }
}
