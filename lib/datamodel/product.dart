import 'package:flutter/material.dart';

class Product {
  late int pid;
  late String pname;
  Product({required this.pid, required this.pname});
  Map<String, dynamic> toMap() {
    return {'pid': pid, 'pname': pname};
  }

  static Product fromMap(Map map) {
    Product product = new Product(pid: map['pid'], pname: map['pname']);
    return product;
  }
}
