import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  const LabelButton(
      {Key? key, required this.labelText, required this.onPressed})
      : super(key: key);
  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        labelText,
        style:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
      ),
      onPressed: onPressed,
    );
  }
}
