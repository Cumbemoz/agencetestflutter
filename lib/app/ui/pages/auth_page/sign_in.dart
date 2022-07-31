// ignore_for_file: avoid_returning_null_for_void, body_might_complete_normally_nullable, avoid_unnecessary_containers

import 'package:agencetest/app/ui/global_widgets/graphics_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../global_widgets/form_input_field_Icon.dart';
import '../../global_widgets/form_vertical_space.dart';

import '../../global_widgets/primary_button.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  // final AuthController _authController = AuthController.init;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(
      init: AuthController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Form(
              key: _loginKey,
              child: Padding(
                padding: EdgeInsets.only(top: size.height / 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: size.height / 10,
                        decoration: const BoxDecoration(
                            //   color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(
                          'assets/imgs/logo2.png',
                        ))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text('Agence Teste',
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ),
                      FormVerticalSpace(),
                      FormVerticalSpace(),
                      const GraphicHeader(),
                      FormVerticalSpace(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width / 10,
                          right: size.width / 10,
                        ),
                        child: FormInputFieldWithIcon(
                            controller: _.emailController,
                            iconPrefix: Icons.email,
                            maxLines: 1,
                            labelText: 'Email',
                            validator: (value) {
                              if (!GetUtils.isEmail(value!)) {
                                return 'Por Favor Insira um Email Válido';
                              }
                            },
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                _.emailController.text = value!),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15,
                            left: size.width / 10,
                            right: size.width / 10),
                        child: Obx(() => FormInputFieldWithIcon(
                            controller: _.passwordController,
                            iconPrefix: Icons.lock,
                            maxLines: 1,
                            sufixIcon: _.passworVisibility.value
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            obscureText: _.passworVisibility.value,
                            onPressed: () {
                              _.passworVisibility.value =
                                  !_.passworVisibility.value;
                            },
                            labelText: "Senha",
                            validator: (value) {
                              if (!GetUtils.isLengthLessThan(value, 5)) {
                                return 'A Senha Deve Ter no Minimo 6 Digitos';
                              }
                            },
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                _.passwordController.text = value!)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 40, right: 40, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: _.rememberMe.value,
                                    onChanged: (value) {
                                      _.rememberMe.value = value!;
                                    }),
                                Text(
                                  'Lembrar de mim',
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.snackbar(
                                      'Olá', 'Ainda Não Estou Disponível',
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                      duration: const Duration(seconds: 3));
                                },
                                child: Text(
                                  "Esqueceu Senha",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ))
                          ],
                        ),
                      ),
                      FormVerticalSpace(),
                      Obx(() => Padding(
                            padding: EdgeInsets.only(
                                left: size.width / 8, right: size.width / 8),
                            child: _.isLoading.value
                                ? Container(
                                    child: CircularProgressIndicator(
                                        color: Colors.greenAccent.shade400),
                                  )
                                : PrimaryButton(
                                    labelText: 'Login',
                                    onPressed: () {
                                      _.loginTheUser(context);
                                    },
                                  ),
                          )),
                      FormVerticalSpace(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("Ou Entrar com:")],
                      ),
                      FormVerticalSpace(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _.loginWithFacebook(context);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              _.loginWithGoogle(context);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
