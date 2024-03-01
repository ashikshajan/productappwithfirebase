import 'package:flutter/material.dart';

import 'package:techware_machinetest/models/product_model.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:techware_machinetest/utils/Utils.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel productsList;
  const ProductDetails({super.key, required this.productsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppUtil.appclrwhite,
          backgroundColor: AppUtil.appprimaryclr,
          automaticallyImplyLeading: true,
          title: const Text(
            "Product Details",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
            child: Column(children: [
          QrImageView(
            size: 200,
            version: QrVersions.auto,
            data: productsList.productName!,
          ),
          Text(
            capitalizeFirstLetter(productsList.productName ?? ""),
            style: TextStyle(
                color: AppUtil.appprimaryclr,
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Price : ${AppUtil.rupeeSymbol}${capitalizeFirstLetter(productsList.productprice ?? "")}",
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            "Size : ${capitalizeFirstLetter(productsList.productMeasurment ?? "")}",
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ])));
  }
}
