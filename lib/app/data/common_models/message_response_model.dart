class MessageResponseModel {
  bool? success;
  String? message;
  var count;
  String? copyrighths;
  String? createdOn;
  var otp;
  var id;

  MessageResponseModel({
    this.success,
    this.message,
    this.count,
    this.id,
    this.copyrighths,
    this.otp,
    this.createdOn,
  });

  MessageResponseModel.fromJson(Map json) {
    success = json['success'];
    message = json['message'];
    otp = json['otp'];
    id = json['id'];
    count = json['count'];
    copyrighths = json['copyrighths'];
    createdOn = json['created_on'];
  }

  Map toJson() {
    final Map data = {};
    data['success'] = success;
    data['message'] = message;
    data['count'] = count;
    data['otp'] = otp;
    data['id'] = id;
    data['copyrighths'] = copyrighths;
    data['created_on'] = createdOn;
    return data;
  }
}
