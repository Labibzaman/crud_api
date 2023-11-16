import 'package:flutter/material.dart';

import '../widgets/floatingActionButton.dart';
import '../widgets/getproduct_method.dart';
import 'product_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async{
            await getProduct();
            setState(() {

            });
          }, icon: Icon(Icons.refresh))
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Product List'),

            ElevatedButton(onPressed: (){

            }, child: Text('Button')),
          ],
        ),
      ),

      floatingActionButton: FloatingButton(),
      body: MyListTile(),
    );
  }

}

