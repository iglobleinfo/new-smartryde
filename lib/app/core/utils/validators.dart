import 'package:flutter/cupertino.dart';
import 'package:smart_ryde/export.dart';

// String? nameTextFieldValidator(
//     String? value,
//     BuildContext context,
//     ) {
//   if (value == null || value.isEmpty) {
//     return localize(context).pleaseEnterName;
//   }
//   return null;
// }

// String? surnameTextFieldValidator(
//     String? value,
//     BuildContext context,
//     ) {
//   if (value == null || value.isEmpty) {
//     return localize(context).pleaseEnterSurname;
//   }
//   return null;
// }

String? phoneTextFieldValidator(
  String countryCode,
  String phoneNumber,
  BuildContext context,
) {
  if (phoneNumber.isEmpty) {
    return stringPhoneNumberValidation.tr;
  } else if (countryCode.contains('91') && phoneNumber.length != 10) {
    return stringPhoneNumberValidValidation.tr;
  } else if (countryCode.contains('825') && phoneNumber.length != 8) {
    return stringPhoneNumberValidValidation.tr;
  }
  return null;
}

String? emailTextFieldValidator(
  String? value,
  BuildContext context,
) {
  if (value == null || value.isEmpty) {
    return stringEmailEmptyValidation.tr;
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return stringEmailValidValidation.tr;
  }
  return null;
}

String? passwordTextFieldValidator(
  String? value,
  BuildContext context, {
  bool validate = true,
}) {
  if (value == null || value.isEmpty) {
    return stringPasswordEmptyValidation.tr;
  }

  final bool containsNumber = RegExp('[0-9]').hasMatch(value);
  final bool containsSpecialChar =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  final bool containsCaps = RegExp('[A-Z]').hasMatch(value);

  if (value.length < 8 ||
      !containsNumber ||
      !containsSpecialChar ||
      !containsCaps) {
    return stringPasswordValidValidation.tr;
  }

  return null;
}

// String? repeatPasswordTextFieldValidator(
//     String? value,
//     String? password,
//     BuildContext context,
//     ) {
//   if (value == null || value.isEmpty) {
//     return localize(context).pleaseEnterPassword;
//   } else if (value != password) {
//     return localize(context).passwordNotMatched;
//   }
//   return null;
// }
//
// String? passcodeTextFieldValidator(
//     String? value,
//     BuildContext context,
//     ) {
//   if (value == null || value.isEmpty) {
//     return localize(context).pleaseEnterPasscode;
//   } else if (value.length < 4) {
//     return localize(context).passcodeLengthMustBeFour;
//   }
//   return null;
// }
