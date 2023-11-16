import 'package:crud_api/widgets/getproduct_method.dart';
import 'package:flutter/material.dart';

import '../screens/add_new_screen.dart';
import '../screens/product_list_screen.dart';

class porduct_item extends StatelessWidget {
  porduct_item({
    super.key,
    required this.product,
    required this.onpressDELTE,
  });

  final Product product;
  final Function(String) onpressDELTE;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          getProduct();
        },
        child: ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: Text('select action'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return addnewScreens(
                                  updateitem: product,
                                );
                              }));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onpressDELTE(product.id);
                            },
                            icon: Icon(Icons.delete_forever_rounded),
                          ),
                        ],
                      ));
                });
          },
          leading: product.image == null
              ? Image.network(
                  product.image ?? '${Icon(Icons.local_airport_sharp)}')
              : Icon(Icons.airplanemode_inactive),
          title: Text(product.productName),
          subtitle: Row(
            children: [
              Text('Code:${product.productCode}'),
              SizedBox(
                width: 7,
              ),
              Text('Price: ${product.unitPRice ?? ''}'),
            ],
          ),
          trailing: Column(
            children: [
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('Buy Now'),
              // ),

              ElevatedButton(onPressed: () {}, child: Text('Buy Now')),
            ],
          ), // You need to define the content of the ListTile.
        ),
      ),
    );
  }
}
