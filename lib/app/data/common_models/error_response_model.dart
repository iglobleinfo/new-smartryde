

class ResponseModel {
  bool? success;
  String? message;
  int? isNotificationEnabled;
  bool? isFavourite;
  String? copyrighths;


  ResponseModel(
      {this.success,
      this.message,
      this.isNotificationEnabled,
      this.copyrighths});

  ResponseModel.fromJson(Map json) {
    success = json['success'];
    message = json['message'];
    isFavourite = json['is_favourite'];
    isNotificationEnabled = json['is_notify'];
    copyrighths = json['copyrighths'];
  }

  Map toJson() {
    final Map data = {};
    data['success'] = success;
    data['message'] = message;
    data['is_favourite'] = isFavourite;
    data['is_notify'] = isNotificationEnabled;
    data['copyrighths'] = copyrighths;
    return data;
  }
}
