import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
        required this.onPressed,
        required this.title,
        this.iconType = Icons.arrow_forward_ios});

  final   Function() onPressed;
  final String title;
  final IconData iconType;

  @override
  State<CustomButton> createState() {
    return _CustomButton();
  }
}

class _CustomButton extends State<CustomButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary)),
        onPressed: _isLoading
            ? null
            : () async {
          setState(() {
            _isLoading = true;
          });
          await widget.onPressed();
          setState(() {
            _isLoading = false;
          });
        },
        child: _isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              widget.iconType,
              size: 16,
              color: Colors.white,
            ),
          ],
        ));
  }
}
