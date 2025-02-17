import 'package:flutter/cupertino.dart';
import 'package:smart_ryde/app/core/values/app_strings.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../values/app_global_values.dart';

Future<XFile?> imageFromCamera(BuildContext context) async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 100);
  if (pickedFile == null && context.mounted) {
    showInSnackBar(message: strNoImage, context: context);
  } else if (context.mounted) {
    return pickedFile;
  }
  return null;
}

/*=================================================================== Image Pick Using Gallery ===================================================*/

Future<XFile?> imageFromGallery(BuildContext context) async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 100);
  if (pickedFile == null && context.mounted) {
    showInSnackBar(message: strNoImage, context: context);
  } else if (context.mounted) {
    return pickedFile;
  }
  return null;
}

Future<PickedFile?> cropImage(filePath, BuildContext context) async {
  var croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  );
  if (croppedImage == null && context.mounted) {
    showInSnackBar(message: strNoImage, context: context);
  } else if (context.mounted) {
    return PickedFile(croppedImage!.path);
  }
  return null;
}
