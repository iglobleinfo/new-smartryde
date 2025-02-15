


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

toast(message, {int seconds = 1}) => Get.snackbar(
      'SmartRyde',
      '$message',
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 6.0,
      animationDuration: Duration(seconds: seconds),
      backgroundColor: primaryColor,
      margin: EdgeInsets.all(20),
      colorText: Colors.white,
    );
