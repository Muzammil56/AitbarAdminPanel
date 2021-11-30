import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Helper {

  void message (BuildContext context, String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,

    );
  }

}