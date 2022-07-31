// ignore_for_file: deprecated_member_use, prefer_if_null_operators

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.labelText,
      required this.onPressed,
      this.sizeheight,
      this.sizeweight,
      this.fontsize})
      : super(key: key);

  final String labelText;
  final double? sizeheight;
  final double? fontsize;
  final double? sizeweight;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeweight == null ? 300 : sizeweight,
      height: sizeheight == null ? 45 : sizeheight,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).primaryColor,
            offset: const Offset(0, 3),
            spreadRadius: 1,
          )
        ],
        borderRadius: BorderRadius.circular(13),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: const Color(0xFF3CFF6A),
        ),
      ),
      child: Center(
        child: TextButton(
          child: Text(
            labelText,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
