// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:agencetest/app/routes/app_pages.dart';
import 'package:agencetest/app/ui/global_widgets/label_button.dart';
import 'package:agencetest/app/ui/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ProductsController extends GetxController {
  var latitude = 'latitude'.obs;
  var longitude = 'longitude'.obs;
  var address = 'Endereco'.obs;
  Completer<GoogleMapController> gMapsController = Completer();
  GoogleMapController? controller;
  Location currentLocation = Location();
  Set<Marker> markers = {};
  bool isLoading = false;
  final box = GetStorage();
  String? name, email, photo, uid;

  LatLng? sourceLocation = const LatLng(-25.969248, 32.5731746);

  @override
  void onInit() {
    getStoredData();
    super.onInit();
  }

  void getStoredData() {
    name = box.read('name');
    email = box.read('email');
    photo = box.read('photo');
    uid = box.read('uid');
  }

  handler(BuildContext context) {
    if (isLoading) {
      loading(context);
    } else {
      success(context);
    }
  }

  confirmBuy(BuildContext context) async {
    getStoredData();
    var textTheme = Theme.of(context).textTheme;
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Row(children: [
                      const Icon(Icons.shopping_cart),
                      Text(
                        "Confirmar Compra",
                        style: textTheme.subtitle1,
                      )
                    ]),
                  ),
                  Text(
                    'Deseja Efectuar essa compra?',
                    style: textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelButton(
                              labelText: 'Cancelar',
                              onPressed: () {
                                Get.back();
                              }),
                          LabelButton(
                              labelText: 'Confirmar',
                              onPressed: () {
                                isLoading = true;
                                handler(context);
                                update();
                              })
                        ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  loading(BuildContext context) async {
    var textTheme = Theme.of(context).textTheme;
    Timer(const Duration(seconds: 5), () {
      isLoading = false;
      handler(context);
      update();
    });
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Row(children: [
                      const Icon(Icons.shopping_cart),
                      Text(
                        "Confirmar Compra",
                        style: textTheme.subtitle1,
                      )
                    ]),
                  ),
                  const CircularProgressIndicator(),
                  Text(
                    'A Efectuar a Compra',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        });
  }

  success(BuildContext context) async {
    var textTheme = Theme.of(context).textTheme;
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Row(children: [
                      const Icon(Icons.done),
                      Text(
                        "Sucesso",
                        style: textTheme.subtitle1,
                      )
                    ]),
                  ),
                  Text(
                    'Compra Efectuada Com Sucesso, Obrigado por Nos escolher',
                    style: textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LabelButton(
                              labelText: 'Confirmar',
                              onPressed: () {
                                Get.to(HomePage(
                                  displayName: name,
                                  photoUrl: photo,
                                  email: email,
                                  uid: uid,
                                ));
                              })
                        ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  void getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));

      markers.add(Marker(
          markerId: const MarkerId('Endereço'),
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      update();
    });
    update();
  }
}
