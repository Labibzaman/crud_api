import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/add_new_screen.dart';
class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: (){

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return addnewScreens();
      }));
    },child: Icon(CupertinoIcons.plus_bubble_fill),);
  }
}
