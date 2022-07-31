import 'package:agencetest/app/ui/pages/auth_page/sign_in.dart';
import 'package:agencetest/app/ui/pages/home_page/home_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => SignIn(),
    ),
  ];
}
