class LoginDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  bool? admin;
  bool? active;
  bool? readOnly;
  DateTime? creatingTime;
  String? language;
  String? fcmToken;
  String? platform;
  String? loginDate;

  LoginDataModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.admin,
    this.active,
    this.readOnly,
    this.creatingTime,
    this.language,
    this.fcmToken,
    this.platform,
    this.loginDate,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    admin: json["admin"],
    active: json["active"],
    readOnly: json["readOnly"],
    creatingTime: json["creatingTime"] == null ? null : DateTime.parse(json["creatingTime"]),
    language: json["language"],
    fcmToken: json["fcmToken"],
    platform: json["platform"],
    loginDate: json["loginDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
    "admin": admin,
    "active": active,
    "readOnly": readOnly,
    "creatingTime": creatingTime?.toIso8601String(),
    "language": language,
    "fcmToken": fcmToken,
    "platform": platform,
    "loginDate": loginDate,
  };
}