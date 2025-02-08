


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

toast(message, {int seconds = 1}) => Get.snackbar(
      'appname',
      '$message',
      borderRadius: 6.0,
      animationDuration: Duration(seconds: seconds),
      backgroundColor: colorMistyRose,
      margin: EdgeInsets.zero,
      colorText: colorVioletM,
    );
