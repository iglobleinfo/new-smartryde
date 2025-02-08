import 'document_data_model.dart';

class LoginDataModel {
  int? id;
  String? fullName;
  String? email;
  String? dateOfBirth;
  int? gender;
  String? countryCode;
  String? contactNo;
  String? language;
  String? profileFile;
  int? tos;
  int? roleId;
  int? stateId;
  int? typeId;
  dynamic otp;
  int? otpVerified;
  int? isNotify;
  String? timezone;
  String? createdOn;
  int? pin;
  int? pinVerified;
  int? isNew;
  String? message;
  int? isProfileCompleted;
  String? country;
  int? stepId;
  String? qrCode;
  bool? isFavorite = false;
  List<DocumentDataModel>? files;

  LoginDataModel({
    this.id,
    this.fullName,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.countryCode,
    this.contactNo,
    this.language,
    this.profileFile,
    this.tos,
    this.isNew,
    this.roleId,
    this.stateId,
    this.typeId,
    this.otp,
    this.isNotify,
    this.otpVerified,
    this.timezone,
    this.createdOn,
    this.pin,
    this.pinVerified,
    this.message,
    this.isProfileCompleted,
    this.country,
    this.stepId,
    this.qrCode,
    this.isFavorite,
    this.files,
  });

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    countryCode = json['country_code'];
    contactNo = json['contact_no'];
    language = json['language'];
    profileFile = json['profile_file'];
    tos = json['tos'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    isNew = json['is_new'];
    typeId = json['type_id'];
    otp = json['otp'];
    isNotify = json['is_notify'];
    otpVerified = json['otp_verified'] ?? 0;
    timezone = json['timezone'];
    createdOn = json['created_on'];
    pin = json['pin'];
    pinVerified = json['pin_verified'];
    message = json['message'];
    isProfileCompleted = json['is_profile_completed'];
    country = json['country'];
    stepId = json['step_id'];
    qrCode = json['qr_code'];
    isFavorite = json['is_favorite'];
    if (json['files'] != null) {
      files = <DocumentDataModel>[];
      json['files'].forEach((v) {
        files!.add(new DocumentDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['country_code'] = countryCode;
    data['contact_no'] = contactNo;
    data['language'] = language;
    data['profile_file'] = profileFile;
    data['tos'] = tos;
    data['role_id'] = roleId;
    data['state_id'] = stateId;
    data['type_id'] = typeId;
    data['is_new'] = isNew;
    data['otp'] = otp;
    data['is_notify'] = isNotify;
    data['otp_verified'] = otpVerified;
    data['timezone'] = timezone;
    data['created_on'] = createdOn;
    data['pin'] = this.pin;
    data['pin_verified'] = this.pinVerified;
    data['message'] = this.message;
    data['is_profile_completed'] = this.isProfileCompleted;
    data['country'] = this.country;
    data['step_id'] = stepId;
    data['qr_code'] = qrCode;
    data['is_favorite'] = this.isFavorite;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
