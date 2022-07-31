import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedScreen = 0;
  changeSelectedScreen(int screen) {
    selectedScreen = screen;
    update();
  }
}
