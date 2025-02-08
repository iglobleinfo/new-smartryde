class MessageResponseModel {
  bool? success;
  String? message;
  var count;
  String? copyrighths;
  String? createdOn;
  var otp;
  var id;

  MessageResponseModel(
      {this.success,
      this.message,
      this.count,
      this.id,
      this.copyrighths,
      this.otp,
      this.createdOn});

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
    final Map data = new Map();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    data['otp'] = this.otp;
    data['id'] = this.id;
    data['copyrighths'] = this.copyrighths;
    data['created_on'] = this.createdOn;
    return data;
  }
}
