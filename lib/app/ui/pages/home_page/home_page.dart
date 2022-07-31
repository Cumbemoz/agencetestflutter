// ignore_for_file: avoid_unnecessary_containers

import 'package:agencetest/app/controllers/auth_controller.dart';
import 'package:agencetest/app/ui/global_widgets/custom_card.dart';
import 'package:agencetest/app/ui/global_widgets/form_vertical_space.dart';
import 'package:agencetest/app/ui/pages/empty_page.dart';
import 'package:agencetest/app/ui/pages/products_page/products_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

import '../../global_widgets/primary_button.dart';

class HomePage extends GetView<HomeController> {
  final String? displayName, email, photoUrl, uid;
  const HomePage(
      {Key? key, this.displayName, this.email, this.photoUrl, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var faker = Faker();
    AuthController auth = AuthController.init;
    Widget productsList() {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: 1.1,
          ),
          itemCount: 20,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                Get.to(ProductsPage(
                  img: faker.image.image(keywords: ['food']),
                  name: faker.food.cuisine(),
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainCard(
                    backgroundColor: Theme.of(context).backgroundColor,
                    borderColor: const Color.fromARGB(255, 197, 195, 195),
                    shadowColor: const Color.fromARGB(255, 101, 104, 102)
                        .withOpacity(0.6),
                    height: 70,
                    width: 100,
                    child: FadeInImage(
                      image:
                          NetworkImage(faker.image.image(keywords: ['food'])),
                      placeholder: const AssetImage("assets/imgs/welcome.png"),
                      imageErrorBuilder: (context, error, sctackTrace) {
                        return Image.asset('assets/imgs/welcome.png');
                      },
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      faker.food.cuisine(),
                      // maxLines: 4,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )
                ],
              ),
            );
          });
    }

    mainScreen() {
      return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ola, ' + displayName.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainCard(
                        backgroundColor: Theme.of(context).backgroundColor,
                        borderColor: const Color.fromARGB(255, 90, 90, 90),
                        shadowColor: const Color.fromARGB(255, 101, 104, 102)
                            .withOpacity(0.6),
                        height: 170,
                        width: 350,
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image.asset(
                                  'assets/imgs/welcome.png',
                                  scale: 4,
                                )),
                            Positioned(
                                left: 6,
                                top: 15,
                                child: Text(
                                  'O que Desejas Comer Hoje \n Aproveite o nosso Maravilhoso cardapio',
                                  style: Theme.of(context).textTheme.subtitle1,
                                )),
                            Positioned(
                                left: 10,
                                bottom: 20,
                                child: PrimaryButton(
                                  labelText: 'Explorar',
                                  onPressed: () {
                                    Get.snackbar('Opps!',
                                        'Essa Função não Foi Adicionada');
                                  },
                                  sizeheight: 45,
                                  sizeweight: 120,
                                  fontsize: 14,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FormVerticalSpace(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Produtos',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    //LabelButton(labelText: 'Ver Todas Aulas', onPressed: () {})
                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: size.height / 2,
                  child: productsList())
            ],
          ),
        ),
      );
    }

    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(
                    "Deseja Sair do Aplicativo?",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        auth.logutheUser();
                      },
                      child: const Text('Confirmar'),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Cancelar'),
                    ),
                  ],
                );
              });
        },
        child: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (_) {},
          builder: (_) {
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              drawer: Padding(
                padding: const EdgeInsets.all(13),
                child: Drawer(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      child: Column(
                        children: [
                          MainCard(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              borderColor: Theme.of(context).primaryColor,
                              shadowColor: Theme.of(context).shadowColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(photoUrl!),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      displayName!,
                                      style: textTheme.subtitle2!.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      email!,
                                      style: textTheme.subtitle2!.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              height: 150,
                              width: double.infinity),
                          FormVerticalSpace(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () {
                                  _.changeSelectedScreen(0);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Inicio",
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () {
                                  _.changeSelectedScreen(1);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Perfil",
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          //FormVerticalSpace(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () {
                                  _.changeSelectedScreen(1);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopify,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Meus Produtos",
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () {
                                  _.changeSelectedScreen(1);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.settings,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Definições",
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () {
                                  auth.logutheUser();
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.logout_outlined,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Sair do Aplicativo",
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              appBar: AppBar(
                //leading: Container(),
                elevation: 0,
                backgroundColor: Theme.of(context).backgroundColor,
                title: Text('Agence Teste',
                    style: Theme.of(context).textTheme.subtitle1),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        //  homeController.tabIndex.value = 3;
                      },
                      child: CircleAvatar(
                        //  foregroundColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        radius: 60.0,
                        child: ClipOval(
                          child: FadeInImage.assetNetwork(
                              placeholder: "assets/imgs/welcome.png",
                              image: photoUrl!),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: IndexedStack(
                index: _.selectedScreen,
                children: [
                  mainScreen(),
                  EmptyPage(),
                ],
              ),
            );
          },
        ));
  }
}
