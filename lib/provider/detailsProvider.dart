import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shoppy/model/products.dart';

class Detailsprovider with ChangeNotifier {
  List<Products> cartupdate = [];
  dynamic price = 0;
  dynamic totalprice = 0;

  addProductToCart(
    dynamic id,
    dynamic name,
    dynamic unitprice,
    dynamic spprice,
    dynamic quanitity,
    dynamic variant,
  ) {
    cartupdate.add(Products(
        id: id,
        name: name,
        unitpr: unitprice,
        specialpr: spprice,
        variant: variant,
        quantity: quanitity));
    cartupdate.length == 0
        ? totalprice = 0
        : totalprice += double.parse(unitprice);

    notifyListeners();
  }

  minusproductTocart(dynamic id, dynamic unitpr) {
    cartupdate.removeWhere((task) => task.id == id);
    cartupdate.length == 0
        ? totalprice = 0
        : totalprice -= double.parse(unitpr);
    notifyListeners();
  }

  List<Products> details = [];
  Future<dynamic> getshopdetail() async {
    try {
      details = [];
      final url = 'https://mocki.io/v1/26ca1ca6-332a-46fe-9df8-392d87a0ecf2';

      final response = await http.get(Uri.parse(url));

      final responseData = await json.decode(response.body);
      List<dynamic> list = await responseData['product_list'] as List;
      list.forEach((element) {
        details.add(Products(
            id: element['tenant_id'],
            quantity: 0,
            specialpr: element['sp'],
            unitpr: element['unitprice'],
            name: element['name'],
            variant:
                element['meta'] == null ? 'No Variant' : element['meta']['variant']));
      });
      //  details.add(Products(id: element['tenant_id'],quantity: 0,specialpr: element['sp'],unitpr: element['unitprice']));
      print(details);
      //details = await responseData['product_list'];
      return details;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
