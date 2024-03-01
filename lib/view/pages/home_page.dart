import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:techware_machinetest/models/product_model.dart';

import 'package:techware_machinetest/utils/Utils.dart';
import 'package:techware_machinetest/utils/app_routes.dart';
import 'package:techware_machinetest/utils/form_widget.dart';
import 'package:techware_machinetest/utils/sharedprefs.dart';
import 'package:techware_machinetest/view/pages/product_det.dart';

import 'package:techware_machinetest/view_model/home/homePageVM.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageVM? homepageController;

  @override
  void initState() {
    super.initState();

    homepageController = Provider.of<HomePageVM>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            homepageController?.createData(ProductModel(
              productMeasurment: homepageController!.productsize.text,
              productName: homepageController!.productname.text,
              productprice: homepageController!.productprice.text,
            ));
          },
          child: Container(
            height: 45,
            width: AppUtil.screensize(context).width * 0.9,
            decoration: BoxDecoration(
                color: AppUtil.appprimaryclr,
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                "Create Data",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  SharedPrefsUtil.logOut();
                  FirebaseAuth.instance.signOut();
                  context.go(AppRoutes.login);
                },
                child: Icon(
                  Icons.logout,
                  color: AppUtil.appclrwhite,
                ),
              ),
            )
          ],
          backgroundColor: AppUtil.appprimaryclr,
          automaticallyImplyLeading: false,
          title: const Text(
            "HomePage",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create a new Product",
                      style: TextStyle(
                          color: AppUtil.appprimaryclr,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormWidget(
                      inputType: TextInputType.text,
                      controller: homepageController?.productname,
                      hintText: "Poduct Name",
                      isPasswordField: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormWidget(
                      inputType: TextInputType.number,
                      controller: homepageController?.productprice,
                      hintText: "Price",
                      isPasswordField: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormWidget(
                      inputType: TextInputType.text,
                      controller: homepageController?.productsize,
                      hintText: "Size",
                      isPasswordField: false,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    StreamBuilder<List<ProductModel?>>(
                        stream: homepageController?.readData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final productsList = snapshot.data;
                          if (productsList!.isEmpty) {
                            return Center(
                                child: Text(
                              "No Data Yet",
                              style: TextStyle(
                                  color: AppUtil.appprimaryclr,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ));
                          }

                          return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                  children: List.generate(
                                      productsList.length,
                                      (index) => ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                          productsList:
                                                              productsList[
                                                                  index]!),
                                                ),
                                              );
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  AppUtil.appprimaryclr,
                                              child: Icon(
                                                Icons.favorite,
                                                color: AppUtil.appclrwhite,
                                              ),
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                homepageController!.deleteData(
                                                    productsList[index]!
                                                        .productId!);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                            title: Text(
                                              capitalizeFirstLetter(
                                                  productsList[index]!
                                                          .productName ??
                                                      ""),
                                              style: TextStyle(
                                                  color: AppUtil.appprimaryclr,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Price : ${AppUtil.rupeeSymbol}${capitalizeFirstLetter(productsList[index]!.productprice ?? "")}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Size :${capitalizeFirstLetter(productsList[index]!.productMeasurment ?? "")}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const Text(
                                                  "",
                                                ),
                                              ],
                                            ),
                                          ))));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
