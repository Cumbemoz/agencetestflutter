import 'package:flutter/material.dart';

class GraphicHeader extends StatelessWidget {
  const GraphicHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/imgs/welcome2.png';
    /*if (themeController.isDarkModeOn == true) {
      _imageLogo = 'assets/images/defaultDark.png';
    } */
    return Hero(
      tag: 'App Logo',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              _imageLogo,
              fit: BoxFit.contain,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
