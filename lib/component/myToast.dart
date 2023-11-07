import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successToast(String msg, bool flag) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: flag ? ToastGravity.BOTTOM : ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 157, 216, 158),
      textColor: Colors.white,
      fontSize: 16.0);
}

void warningToast(String msg, bool flag) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: flag ? ToastGravity.BOTTOM : ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[300],
      textColor: Colors.white,
      fontSize: 16.0);
}
