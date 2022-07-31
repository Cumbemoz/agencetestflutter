import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final double width, height;
  final Color shadowColor, borderColor, backgroundColor;
  final Widget child;
  const MainCard(
      {Key? key,
      required this.backgroundColor,
      required this.borderColor,
      required this.shadowColor,
      required this.child,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: shadowColor,
            offset: const Offset(0, 3),
            spreadRadius: 1.2,
          )
        ],
        borderRadius: BorderRadius.circular(13),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: child,
    );
  }
}
