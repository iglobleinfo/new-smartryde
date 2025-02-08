import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'DeviceDetails.dart';

class FlutterLogger {
  static Dio? dio;
  static PackageInfo? packageInfo;

  init({String? reportURL}) {
    PlatformDispatcher.instance.onError = (error, stack) {
      recordCrash(reportURL: reportURL, stackTrace: error.toString() + '\n' + stack.toString());
      return true;
    };
  }

  static FlutterLogger getInstance() {
    dio = Dio();
    findPackageDetails();
    return FlutterLogger();
  }

  static findPackageDetails() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  Future<int?> recordCrash({String? reportURL, String? stackTrace}) async {
    final formData = (await logCrashErrorReq(stackTrace: stackTrace));
    deleteOldFile();
    writeFile(jsonEncode(formData));
    final response = await dio!.post(reportURL!, data: FormData.fromMap(formData));
    return response.statusCode;
  }

  static Future<Map<String, dynamic>> logCrashErrorReq({
    stackTrace,
  }) async {
    DeviceDetails details = await DeviceDetails().getDeviceData();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LogTime'] = DateFormat.yMEd().add_jms().format(DateTime.now());
    data['Log[link]'] = details.deviceVersion;
    data['Log[referer_link]'] = details.deviceName;
    data['Log[user_ip]'] = details.deviceID;
    data['Log[stackTrace]'] = stackTrace;
    return data;
  }

  //write file
  writeFile(String text) async {
    final Directory directory = await getApplicationCacheDirectory();
    final File file = File('${directory.path}/log_file.txt');
    await file.writeAsString(text);
    readFile();
  }

  //Read file
  Future<Map<String, dynamic>> readFile() async {
    String text = "";
    try {
      final Directory directory = await getApplicationCacheDirectory();
      final File file = File('${directory.path}/log_file.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return jsonDecode(text);
  }

  //delete old file
  deleteOldFile() async {
    final Directory directory = await getApplicationCacheDirectory();
    final File file = File('${directory.path}/log_file.txt');
    await file.delete();
  }

  // Force crash in flutter
  forceCrash() {
    recordCrash(reportURL: "crashBaseUrl", stackTrace: "This is a crash!");
    throw "This is a crash!";
  }
}
