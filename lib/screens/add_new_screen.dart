import 'dart:convert';
import 'dart:core';

import 'package:crud_api/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class addnewScreens extends StatefulWidget {
  const addnewScreens({super.key, this.updateitem});

  final Product? updateitem;

  @override
  State<addnewScreens> createState() => _addnewScreensState();
}

class _addnewScreensState extends State<addnewScreens> {
  TextEditingController _titleContr = TextEditingController();
  TextEditingController _productCodeContr = TextEditingController();
  TextEditingController _imageContr = TextEditingController();
  TextEditingController _QuantityContr = TextEditingController();
  TextEditingController _priceContr = TextEditingController();
  TextEditingController _DescripContr = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool inProgress = false;

  Future<void> createPrduct() async {
    inProgress = true;
    setState(() {});
    Response response = await post(
      Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "Img": _imageContr.text.trim(),
          "ProductCode": _productCodeContr.text.trim(),
          "ProductName": _titleContr.text.trim(),
          "Qty": _QuantityContr.text.trim(),
          "UnitPrice": _priceContr.text.trim(),
        },
      ),
    );
    inProgress = false;
    setState(() {});
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product has benn added')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('failed Product has not added')));
    }
  }
  Future<void> UpdateProduct() async {
    inProgress = true;
    setState(() {});
    Response response = await post(
      Uri.parse('https://crud.teamrabbil.com/api/v1/${widget.updateitem!.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "Img": _imageContr.text.trim(),
          "ProductCode": _productCodeContr.text.trim(),
          "ProductName": _titleContr.text.trim(),
          "Qty": _QuantityContr.text.trim(),
          "UnitPrice": _priceContr.text.trim(),
        },
      ),
    );
    inProgress = false;
    setState(() {});
    print(response.statusCode);
    print(widget.updateitem!.id);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product has benn Updated')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('failed Product has not Updated')));
    }
  }

  @override
  void initState() {
    if (widget.updateitem != null) {
      _titleContr.text = widget.updateitem?.productName;
      _productCodeContr.text = widget.updateitem?.productCode;
      _priceContr.text = widget.updateitem?.unitPRice;
      _imageContr.text = widget.updateitem?.image;
      _QuantityContr.text = widget.updateitem?.quantity;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add New Product')),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleContr,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter here',
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter value';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _productCodeContr,
              decoration: InputDecoration(
                labelText: 'Product Code',
                hintText: 'Enter here',
              ),
              validator: isValidate,
            ),
            TextFormField(
              controller: _imageContr,
              decoration: InputDecoration(
                labelText: 'Product Image',
                hintText: 'Enter here',
              ),
              validator: isValidate,
            ),
            TextFormField(
              controller: _QuantityContr,
              decoration: InputDecoration(
                labelText: 'Quantity',
                hintText: 'Enter here',
              ),
              validator: isValidate,
            ),
            TextFormField(
              controller: _priceContr,
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: ' Total Price',
              ),
              validator: isValidate,
            ),
            SizedBox(
              height: 10,
            ),
            inProgress
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if(widget.updateitem == null){
                          createPrduct();
                        }else{
                          UpdateProduct();
                        }

                        if(widget.updateitem==null){
                          TextfiledClear();
                        }
                      }
                    },
                    child: widget.updateitem == null
                        ? Text('Add')
                        : Text('update'),
                  )
          ],
        ),
      ),
    );
  }

  String? isValidate(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Enter value';
    }
    return null;
  }

  void TextfiledClear() {
    _QuantityContr.clear();
    _imageContr.clear();
    _priceContr.clear();
    _titleContr.clear();
    _productCodeContr.clear();
  }
}
