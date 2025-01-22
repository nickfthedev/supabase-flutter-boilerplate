import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  tertiary,
}

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: variant == ButtonVariant.primary
            ? Theme.of(context).colorScheme.primary
            : variant == ButtonVariant.secondary
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.tertiary,
        foregroundColor: variant == ButtonVariant.primary
            ? Theme.of(context).colorScheme.onPrimary
            : variant == ButtonVariant.secondary
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.onTertiary,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: variant == ButtonVariant.primary
            ? BorderSide(color: Theme.of(context).colorScheme.primary)
            : variant == ButtonVariant.secondary
                ? BorderSide(color: Theme.of(context).colorScheme.secondary)
                : BorderSide(color: Theme.of(context).colorScheme.tertiary),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
