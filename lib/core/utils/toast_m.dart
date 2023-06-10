import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastM {
  static show(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.grey[700]);
  }

  static showCenter(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.grey[700],
        gravity: ToastGravity.CENTER);
  }
}
