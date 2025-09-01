import 'package:smart_ryde/app/core/utils/time_ago.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../export.dart';
import '../values/app_global_values.dart';

int backPressCounter = 0;

SizedBox emptySizeBox() => const SizedBox(
      height: 0.0,
      width: 0.0,
    );

Center resultNotFound({
  String? message,
  required BuildContext context,
}) =>
    Center(
      child: Text(
        message ?? keyNoResultFound.tr,
        style: textStyleBody2(context),
      ),
    );

loadingWidget() => const Center(
        child: CircularProgressIndicator(
      color: colorAppColor,
      backgroundColor: Colors.white,
    ));

utcToLocalReviewsDate(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = DateFormat('dd MMMM yyyy').format(dateTime);
  return df;
}

utcToLocalReviewsDateTime(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = DateFormat('dd MMMM yyyy hh:mm:ss a').format(dateTime);
  return df;
}

utcToLocalLatestNewsDate(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = DateFormat('dd MMM yyyy').format(dateTime);
  return df;
}

utCtoGMT(var dates) {
  var date = DateFormat("yyyy-MM-dd").format(DateTime.parse(dates).toUtc());
  return date;
}

timeNow(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = TimeAgo.timeAgoSinceDate(dateTime.toString());
  return df;
}

extension StringExtensions on String {
  String capitalized() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

convertTimeToLocal({dateString, dateFormat}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse('${dateString}Z');
    final convertLocal = strToDateTime.toLocal();
    DateFormat newFormat = DateFormat(dateFormat ?? "MM.dd.yyyy");
    return newFormat.format(convertLocal);
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

Widget getInkWell({child, onTap}) {
  return GestureDetector(
    onTap: onTap ?? () {},
    child: child,
  );
}

Widget noDataToShow({
  required BuildContext context,
  inputText,
  color = Colors.black,
}) {
  return Center(
    child: TextView(
      text: inputText ?? 'No Data Found',
      textStyle: textStyleBody1(context),
    ),
  );
}

Future<bool> onWillPop(BuildContext context) {
  debugPrint(backPressCounter.toString());
  if (backPressCounter < 1) {
    showInSnackBar(message: keyPressToExitApp.tr, context: context);
    backPressCounter++;
    Future.delayed(const Duration(milliseconds: 1500), () {
      backPressCounter--;
    });
    return Future.value(false);
  } else {
    if (GetPlatform.isAndroid) {
      SystemNavigator.pop();
    }
    return Future.value(true);
  }
}

Future<MultipartFile?> convertToMultipart(String image) async {
  debugPrint(":::::::$image");
  MultipartFile? multipartImage;
  if (image != "" && !image.contains("http")) {
    multipartImage = await MultipartFile.fromFile(image,
        filename: image.split("/").toString());
  }
  debugPrint("MultipartImage ${multipartImage.toString()}");
  return multipartImage;
}

Future<List<MultipartFile>?> convertListToMultipart(
    List<String>? imageList) async {
  List<MultipartFile> multiPartList = [];
  if (imageList!.isNotEmpty) {
    for (int i = 0; i < imageList.length; i++) {
      if (!(imageList[i].contains("http"))) {
        multiPartList.add(
          await MultipartFile.fromFile(
            imageList[i],
            filename: imageList[i].split("/").toString(),
          ),
        );
      }
    }
  }
  debugPrint("MultiPartImageList ${multiPartList.length}");
  return multiPartList;
}

bottomSheetWidget({builder, icon, Function()? onTap, bool? buttonVisible}) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      barrierColor: Colors.black54,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: Get.context!,
      builder: (BuildContext context) {
        return Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonVisible != null
                ? emptySizeBox()
                : InkWell(
                    onTap: onTap,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: icon,
                    ).marginOnly(right: 10, bottom: 10)),
            SizedBox(
              height: height_5,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: builder,
            ),
          ],
        );
      });
}

// calendarWidget(
//     {void Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged,
//     Widget Function(BuildContext, DateRangePickerCellDetails)? cellBuilder,
//     PickerDateRange? value}) {
//   return Container(
//     decoration: const BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 20.0,
//         ),
//       ],
//     ),
//     child: Center(
//       child: SfDateRangePicker(
//         headerHeight: height_70,
//         view: DateRangePickerView.month,
//         selectionMode: DateRangePickerSelectionMode.range,
//         monthCellStyle: const DateRangePickerMonthCellStyle(
//           textStyle: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         selectionTextStyle: const TextStyle(
//           color: Colors.white,
//         ),
//         startRangeSelectionColor: colorAppColors,
//         endRangeSelectionColor: colorAppColors,
//         rangeSelectionColor: textFieldBgClr,
//         cellBuilder: cellBuilder,
//         todayHighlightColor: Colors.black,
//         rangeTextStyle: TextStyle(
//           color: Colors.black,
//           fontSize: font_15,
//         ),
//         headerStyle: DateRangePickerHeaderStyle(
//           backgroundColor: colorAppColors,
//           textAlign: TextAlign.center,
//           textStyle: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: font_25),
//         ),
//         backgroundColor: Colors.white,
//         selectionShape: DateRangePickerSelectionShape.rectangle,
//         onSelectionChanged: onSelectionChanged,
//         initialSelectedRange:
//             value /* PickerDateRange(DateTime.now().subtract(const Duration(days: 4)), DateTime.now().add(const Duration(days: 3)))*/,
//       ),
//     ),
//   );
// }
//
// calendarView() {
//   return Container(
//     height: height_300,
//     decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           const BoxShadow(
//             color: Colors.black12,
//             blurRadius: 2,
//             offset: Offset(
//               1,
//               1,
//             ),
//           ),
//           const BoxShadow(
//             color: Colors.black12,
//             blurRadius: 2,
//             offset: Offset(
//               1,
//               1,
//             ),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(10)),
//     child: SfCalendar(
//       dataSource: MeetingDataSource(
//         _getDataSource(),
//       ),
//       controller: _calendarController,
//       cellBorderColor: Colors.transparent,
//       initialSelectedDate: DateTime.now(),
//       todayHighlightColor: colorAppColors,
//       minDate: DateTime(2019, 10, 10, 9, 0, 0),
//       headerStyle: const CalendarHeaderStyle(
//           textAlign: TextAlign.center,
//           backgroundColor: colorAppColors,
//           textStyle: TextStyle(
//               fontSize: 25,
//               fontStyle: FontStyle.normal,
//               letterSpacing: 5,
//               color: Colors.white,
//               fontWeight: FontWeight.w500)),
//       viewHeaderStyle: ViewHeaderStyle(
//         backgroundColor: textFieldBgClr,
//         dayTextStyle: const TextStyle(
//           color: colorAppColors,
//           fontSize: 20,
//         ),
//         dateTextStyle: const TextStyle(
//           color: colorAppColors,
//           fontSize: 25,
//         ),
//       ),
//       view: CalendarView.month,
//       monthViewSettings: const MonthViewSettings(
//         appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
//       ),
//     ),
//   ).paddingAll(10);
// }
//
// final CalendarController _calendarController = CalendarController();
//
// List<Meeting> _getDataSource() {
//   final List<Meeting> meetings = <Meeting>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Meeting(
//       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//   return meetings;
// }
//
// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
