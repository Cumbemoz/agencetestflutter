// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:agencetest/app/data/services/auth_service.dart';
import 'package:agencetest/app/routes/app_pages.dart';
import 'package:agencetest/app/ui/global_widgets/form_vertical_space.dart';
import 'package:agencetest/app/ui/global_widgets/label_button.dart';
import 'package:agencetest/app/ui/pages/home_page/home_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/services/utility_service.dart';

class AuthController extends GetxController {
  static AuthController init = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final UtilityService _utilityService = UtilityService();
  final passworVisibility = true.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;
  RxBool isOnline = true.obs;
  final box = GetStorage();

  checkConnection() {
    update();
    _utilityService.checkConnectivity().then((value) => {
          if (value != isOnline.value) {isOnline.value = value},
          if (isOnline.value == false)
            {
              isLoading.value = false,
              Get.snackbar(
                  'Ooopsss!!', 'Parece que Não Estás Conectado a Internet')
            }
        });
    update();
    return false;
  }

  loginTheUser(BuildContext context) {
    Faker faker = Faker();
    Get.to(HomePage(
      displayName: faker.person.name(),
      email: faker.person.name() + '@gmail.com',
      photoUrl: faker.image.image(keywords: ['Person']),
      uid: faker.guid.guid(),
    ));
  }

  loginWithFacebook(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          String? displayName = '', email = '', photourl = '', uid = '';

          AuthService().signInWithFacebook().then((result) {
            //    print(result.user!.displayName);
            displayName = result.user!.displayName!;
            email = result.user!.email!;
            photourl = result.user!.photoURL!;
            uid = result.user!.uid;
            update();
          });

          return GetBuilder<AuthController>(
            init: AuthController(),
            initState: (_) {},
            builder: (_) {
              return AlertDialog(
                backgroundColor: Theme.of(context).backgroundColor,
                content: uid == ''
                    ? Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Text(
                              'A Fazer Login...',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Seja Bem Vindo ' + displayName.toString(),
                                style: Theme.of(context).textTheme.subtitle1),
                            FormVerticalSpace(),
                            Text(
                                'Nesse maravilhoso Aplicativo vais Poder Ver Tudo o que precisas',
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                      ),
                actions: [
                  uid == ''
                      ? Container()
                      : LabelButton(
                          labelText: 'Continuar',
                          onPressed: () {
                            //      print(photourl);
                            Get.to(HomePage(
                              displayName: displayName,
                              email: email,
                              photoUrl: photourl,
                              uid: uid,
                            ));
                          })
                ],
              );
            },
          );
        });
  }

  logutheUser() {
    AuthService().logout();
    exit(0);
  }

  loginWithGoogle(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          String? displayName = '', email = '', photourl = '', uid = '';

          AuthService().signInWithGoogle().then((result) {
            //    print(result.user!.displayName);
            displayName = result.user!.displayName!;
            email = result.user!.email!;
            photourl = result.user!.photoURL!;
            uid = result.user!.uid;
            update();
          });

          return GetBuilder<AuthController>(
            init: AuthController(),
            initState: (_) {},
            builder: (_) {
              return AlertDialog(
                backgroundColor: Theme.of(context).backgroundColor,
                content: uid == ''
                    ? Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Text(
                              'A Fazer Login...',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Seja Bem Vindo ' + displayName.toString(),
                                style: Theme.of(context).textTheme.subtitle1),
                            FormVerticalSpace(),
                            Text(
                                'Nesse maravilhoso Aplicativo vais Poder Ver Tudo o que precisas',
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                      ),
                actions: [
                  uid == ''
                      ? Container()
                      : LabelButton(
                          labelText: 'Continuar',
                          onPressed: () {
                            box.write('name', displayName);
                            box.write('email', email);
                            box.write('photo', photourl);
                            box.write('uid', uid);
                            Get.to(HomePage(
                              displayName: displayName,
                              email: email,
                              photoUrl: photourl,
                              uid: uid,
                            ));
                          })
                ],
              );
            },
          );
        });
  }
}
