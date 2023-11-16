import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widgets/getproduct_method.dart';
import '../widgets/product_item.dart';

class MyListTile extends StatefulWidget {
  const MyListTile({
    Key? key,
  }) : super(key: key);

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  List<Product> productList = [];
  bool inProgress = false;

  @override
  void initState() {
    getProduct();

    super.initState();
  }

  void getProduct() async {
    productList.clear();
    inProgress = true;
    setState(() {});
    Response response =
        await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['status'] == 'success') {
        for (Map<String, dynamic> productJson in responseBody['data']) {
          productList.add(Product(
            productJson['_id'] ?? '',
            productJson['ProductCode'] ?? '',
            productJson['ProductName'] ?? '',
            productJson['Img'] ?? '',
            productJson['UnitPrice'] ?? '',
            productJson['Qty'] ?? '',
            productJson['TotalPrice'] ?? '',
          ));
        }
      }
    }
    inProgress = false;
    print(productList.length);
    setState(() {});
  }

  void deleteProduct(String porductId) async {
    inProgress = true;
    setState(() {});
    Response response = await get(Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$porductId'));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      getProduct();
    } else {
      inProgress = false;
      print(productList.length);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return inProgress
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              ;
              return porduct_item(
                product: productList[index],
                onpressDELTE: (String porductId) {
                  deleteProduct(porductId);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1);
            },
          );
  }
}

class Product {
  final dynamic id;
  final dynamic productName;
  final dynamic productCode;
  final dynamic image;
  final dynamic unitPRice;
  final dynamic quantity;
  final dynamic? totalPRice;

  Product(
    this.id,
    this.productName,
    this.productCode,
    this.image,
    this.unitPRice,
    this.quantity,
    this.totalPRice,
  );
}
