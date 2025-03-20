import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

toast(message, {int seconds = 1}) => Get.snackbar(
      'SmartRyde',
      titleText: Text(
        'SmartRyde',
        style: TextStyle(color: Colors.white, fontSize: 19),
      ),
      '$message',
      messageText: Text(
        '$message',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 6.0,
      animationDuration: Duration(seconds: seconds),
      backgroundColor: primaryColor,
      margin: EdgeInsets.all(10),
      colorText: Colors.white,
    );
