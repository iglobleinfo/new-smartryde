


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/export.dart';

class CustomFutureBuilder extends StatelessWidget {
  const CustomFutureBuilder(
      {Key? key,
      this.future,
      required this.responseModel,
      required this.widget})
      : super(key: key);
  final Future? future;
  final responseModel;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, result) {
        log.e(result);

        switch (result.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            {
              if (result.hasData) {
                return responseModel?.list != null &&
                        responseModel?.list?.length != 0
                    ? widget
                    : Center(
                        child: Container(
                        margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: Text('No Data Found'.tr),
                      ));
              } else {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: Text('No Data Found'.tr),
                ));
              }
            }
          case ConnectionState.none:
            return Container();
          default:
            return Container();
        }
      },
    );
  }
}
