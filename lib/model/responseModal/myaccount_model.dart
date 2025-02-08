

class MyAccountModel {
  String? fullname;
  String? email;
  String? mobile;

  MyAccountModel({this.fullname, this.email, this.mobile});

  MyAccountModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}
