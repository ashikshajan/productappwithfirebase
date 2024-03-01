// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:techware_machinetest/models/product_model.dart';

class HomePageVM extends ChangeNotifier {
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productsize = TextEditingController();

  Stream<List<ProductModel>> readData() {
    // readData() {
    final productCollection = FirebaseFirestore.instance.collection("products");

    return productCollection
        .snapshots()
        .map((qureySnapshot) => qureySnapshot.docs
            .map(
              (e) => ProductModel.fromSnapshot(e),
            )
            .toList());
  }

  void createData(ProductModel productsmodel) {
    final productCollection = FirebaseFirestore.instance.collection("products");

    String id = productCollection.doc().id;

    final newProduct = ProductModel(
      productName: productsmodel.productName,
      productMeasurment: productsmodel.productMeasurment,
      productprice: productsmodel.productprice,
      productId: id,
    ).toJson();

    productCollection.doc(id).set(newProduct);
    clear();
  }

  // void updateData(ProductModel productsmodel) {
  //   final productCollection = FirebaseFirestore.instance.collection("products");

  //   final newData = ProductModel(
  //     productName: productsmodel.productName,
  //     productMeasurment: productsmodel.productMeasurment,
  //     productprice: productsmodel.productprice,
  //     productId: productsmodel.productId,
  //   ).toJson();

  //   productCollection.doc(productsmodel.productId).update(newData);
  // }

  void deleteData(String id) {
    final productCollection = FirebaseFirestore.instance.collection("products");

    productCollection.doc(id).delete();
    clear();
  }

  clear() {
    productname.clear();
    productprice.clear();
    productsize.clear();
    notifyListeners();
  }
}
