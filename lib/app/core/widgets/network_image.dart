/*
 *
 *  * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import '../../../export.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageurl;
  final double? radiusAll;
  final double radiusTopRight;
  final double radiusTopLeft;
  final double radiusBottomRight;
  final double radiusBottomLeft;
  final double imageHeight;
  final double imageWidth;
  final BoxFit imageFitType;
  final color;
  final placeHolder;

  const NetworkImageWidget(
      {Key? key,
        required this.imageurl,
        this.radiusAll,
        this.radiusTopLeft = 0.0,
        this.radiusBottomRight = 0.0,
        this.radiusBottomLeft = 0.0,
        this.radiusTopRight = 0.0,
        this.imageHeight = 0.0,
        this.imageWidth = 0.0,
        this.color,
        this.placeHolder,
        this.imageFitType = BoxFit.fill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: radiusAll == null
            ? BorderRadius.only(
            topRight: Radius.circular(radiusTopRight),
            topLeft: Radius.circular(radiusTopLeft),
            bottomLeft: Radius.circular(radiusBottomLeft),
            bottomRight: Radius.circular(radiusBottomRight))
            : BorderRadius.circular(radiusAll!),
        child: FancyShimmerImage(
          height: imageHeight,
          width: imageWidth,
          boxFit: imageFitType,
          imageUrl: imageurl ?? "",
          errorWidget: AssetImageWidget(
            imageUrl: placeHolder ?? iconProfile,
            radiusAll: radiusAll,
            imageHeight: imageHeight,
            imageWidth: imageWidth,
            imageFitType:imageFitType,
          ),
        ));
  }
}
