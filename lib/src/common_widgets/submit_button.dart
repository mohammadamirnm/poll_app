import 'package:flutter/material.dart';
import 'package:poll_app/src/helpers/context_extension.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.text, this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: context.theme.textTheme.labelMedium,
        ),
      ),
    );
  }
}
