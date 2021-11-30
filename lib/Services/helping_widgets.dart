import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

Widget ReusableContainer({required BuildContext context,required Widget child}){
  return Container(
    height: MediaQuery.of(context).size.width / 6,
    width: MediaQuery.of(context).size.width / 4,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child:  Center(child: child),
  );
}

Widget ReusableButton ({required String text,required Color color,required dynamic onPressed}){
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text),
    ),
  );
}