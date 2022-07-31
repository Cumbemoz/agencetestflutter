// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon(
      {Key? key,
      required this.controller,
      this.iconPrefix,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.sufixIcon,
      this.onPressed,
      this.prefix,
      this.maxLength,
      this.validationType,
      required this.onChanged,
      required this.onSaved})
      : super(key: key);

  final TextEditingController controller;
  final IconData? iconPrefix;
  final IconData? sufixIcon;
  final String labelText;
  final String? prefix;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines, maxLength;
  final AutovalidateMode? validationType;
  final void Function(String) onChanged;
  final void Function()? onPressed;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      //  height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black,
            offset: Offset(0, 3),
            spreadRadius: 1.3,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        //    shape: BoxShape.rectangle,
      ),
      child: TextFormField(
        decoration: InputDecoration(
            prefixText: prefix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            floatingLabelStyle: Theme.of(context).textTheme.subtitle2,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).focusColor)),
            focusColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).backgroundColor,
            iconColor: Theme.of(context).primaryColor,
            hoverColor: Theme.of(context).primaryColor,
            prefixIcon: Icon(iconPrefix),
            labelText: labelText,
            suffixIcon: sufixIcon == null
                ? null
                : IconButton(
                    icon: Icon(sufixIcon),
                    onPressed: onPressed,
                  )),
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        autovalidateMode: validationType,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
        validator: validator,
      ),
    );
  }
}
