import 'package:agencetest/app/controllers/auth_controller.dart';
import 'package:agencetest/app/controllers/home_controller.dart';
import 'package:agencetest/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Firebase.initializeApp();
  Get.put<AuthController>(AuthController());
  Get.put<HomeController>(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.LOGIN,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
