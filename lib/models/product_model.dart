import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? productName;
  final dynamic productprice;

  final String? productId;
  final String? productMeasurment;

  ProductModel(
      {this.productName,
      this.productprice,
      this.productId,
      this.productMeasurment});

  static ProductModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ProductModel(
      productName: snapshot['productname'],
      productprice: snapshot['productprice'],
      productId: snapshot['productid'],
      productMeasurment: snapshot['productmeasurement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productname": productName,
      "productprice": productprice,
      "productid": productId,
      "productmeasurement": productMeasurment,
    };
  }
}
