import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceDetails{
  
  String? deviceName;
  String? deviceID;
  String? deviceVersion;
  String? deviceType;

  DeviceDetails({this.deviceName, this.deviceID, this.deviceVersion, this.deviceType});


  Future<DeviceDetails> getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;


      return DeviceDetails(deviceID: androidDeviceInfo.id,deviceName: androidDeviceInfo.model,deviceType: androidDeviceInfo.device,deviceVersion: androidDeviceInfo.version.release);

    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;

      return DeviceDetails(deviceID: iosDeviceInfo.identifierForVendor,deviceName: iosDeviceInfo.model,deviceType: iosDeviceInfo.localizedModel,deviceVersion: iosDeviceInfo.systemVersion);

    }else{
      return Future.error("");
    }
  }
}