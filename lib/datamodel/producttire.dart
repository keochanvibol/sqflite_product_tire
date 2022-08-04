import 'package:app_tireproduct/datamodel/product.dart';
import 'package:flutter/material.dart';

class ProductTire {
  late int ptid;
  late int pid;
  late String ptprice;
  late String ptimage;
  ProductTire(
      {required this.ptid,
      required this.pid,
      required this.ptprice,
      required this.ptimage});
  Map<String, dynamic> toMap() {
    return {'ptid': ptid, 'pid': pid, 'ptprice': ptprice, 'ptimage': ptimage};
  }

  static ProductTire fromMap(Map map) {
    ProductTire productTire = new ProductTire(
        ptid: map['ptid'],
        pid: map['pid'],
        ptprice: map['ptprice'],
        ptimage: map['ptimage']);
    return productTire;
  }
}
