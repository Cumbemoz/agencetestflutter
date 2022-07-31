// ignore_for_file: sized_box_for_whitespace

import 'package:agencetest/app/ui/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/products_controller.dart';

class ProductsPage extends GetView<ProductsController> {
  final String? name, img;
  const ProductsPage({Key? key, this.name, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return GetBuilder<ProductsController>(
      init: ProductsController(),
      initState: (_) {},
      builder: (_) {
        _.getLocation();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(name!),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                _.confirmBuy(context);
              },
              tooltip: 'Efectuar Compra',
              backgroundColor: Theme.of(context).backgroundColor,
              child: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              )),
          backgroundColor: Theme.of(context).backgroundColor,
          body: RefreshIndicator(
            onRefresh: () async {
              _.getLocation();
            },
            child: Stack(
              children: [
                Container(
                  height: size.height / 3,
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    markers: _.markers,
                    onMapCreated: (GoogleMapController controller) {
                      _.controller = controller;
                    },
                    initialCameraPosition:
                        CameraPosition(target: _.sourceLocation!, zoom: 12.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height / 2.3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  child: Container(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: size.height / 3,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(img!, scale: 2))),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: SizedBox(
                                        height: size.height,
                                        width: size.width / 2.6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20)),
                                              color: Theme.of(context)
                                                  .backgroundColor
                                                  .withOpacity(0.8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  name!,
                                                  style: textTheme.headline5!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  loremText,
                                                  style: textTheme.bodyLarge,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
