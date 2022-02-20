import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ControllerToastMessages{

  static messageFromError(String message){
    Fluttertoast.showToast(
        msg: message.substring(11),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 2);
  }

  static genericMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 2);
  }

}