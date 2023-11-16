
import 'dart:convert';

import 'package:http/http.dart';

import '../screens/product_list_screen.dart';

List<Product> productList = [];
bool inProgress = false;

Future getProduct() async {
  inProgress = true;
  Response response =
  await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'success') {
      for (Map<String, dynamic> productJson in responseBody['data']) {
        productList.add(Product(
          productJson['_id'],
          productJson['ProductCode'],
          productJson['ProductName'],
          productJson['Img'],
          productJson['UnitPrice'],
          productJson['Qty'],
          productJson['TotalPrice'],
        ));
      }
    }
  }
  inProgress=false;
  print(productList.length);

}