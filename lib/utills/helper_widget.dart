

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static bool isSnackBarVisible = false;

  static String getString(dynamic value) {
    return (value == null || value == 'null') ? "" : value;
  }


  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,

    );
  }


}
