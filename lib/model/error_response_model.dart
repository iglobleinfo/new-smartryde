

class ErrorMessageResponseModel {
  bool? success;
  String? message;
  String? copyrighths;

  ErrorMessageResponseModel({this.success, this.message, this.copyrighths});

  ErrorMessageResponseModel.fromJson(Map json) {
    success = json['success'];
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map toJson() {
    final Map data = new Map();
    data['success'] = this.success;
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}