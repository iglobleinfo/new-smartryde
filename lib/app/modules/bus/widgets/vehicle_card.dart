// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/values/text_styles.dart';
//
// class VehicleCard extends StatelessWidget {
//   const VehicleCard({
//     super.key,
//     // required this.vehicle,
//   });
//   // final Vehicle vehicle;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 2,
//       ),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             // border: Border.all(
//             //   width: 0.5,
//             // ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 getTopSection(context),
//                 const SizedBox(height: 8),
//                 getBottomSection(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget getTopSection(BuildContext context) {
//     return Row(
//       children: [
//         Image.asset(
//           'iconCarPng', // Replace with your car image asset
//           width: 80.w,
//           height: 80.w,
//           fit: BoxFit.cover,
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text("${vehicle.numberPlate}",
//                         style: textStyleBodyLarge(context)),
//                   ),
//                   Wrap(
//                     children: [
//                       Image.asset(
//                         'iconSatellitePng',
//                         height: 20.h,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset(
//                         'iconCarBatteryPng',
//                         height: 17.h,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset(
//                         'iconKeyPng',
//                         height: 15.h,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset(
//                         'iconAcPng',
//                         height: 19.h,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset(
//                         'iconParkingPng',
//                         height: 15.h,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: 5),
//               Row(
//                 children: [
//                   Image.asset(
//                     'iconClockPng',
//                     height: 18.h,
//                   ),
//                   SizedBox(width: 5.w),
//                   Expanded(
//                     child: Text(
//                       "09:51 PM, 15 Feb 2025",
//                       style: textStyleBodyMedium(context),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.h),
//               Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: vehicle.vehicleType?.color,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "${vehicle.vehicleType?.name}",
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ),
//                   const Spacer(),
//                   Icon(Icons.speed, size: 20, color: Colors.black),
//                   const SizedBox(width: 4),
//                   Text(
//                     "${vehicle.mileage} kmph",
//                     style: textStyleBodyMedium(context),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget getBottomSection(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(
//           iconPinPng,
//           height: 20.h,
//         ),
//         const SizedBox(width: 6),
//         Expanded(
//           child: Text(
//             "${vehicle.lastLocation}",
//             style: textStyleBodyMedium(context),
//             softWrap: true,
//           ),
//         ),
//       ],
//     );
//   }
// }
