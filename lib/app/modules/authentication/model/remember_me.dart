class RememberMeModel {
  String? email;
  String? mobile;
  String? password;

  RememberMeModel({this.email,this.mobile, this.password});

  RememberMeModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    return data;
  }
}
