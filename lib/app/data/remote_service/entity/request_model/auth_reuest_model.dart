// Project imports:
class AuthRequestModel {
  static loginReq({
    required String phoneNumber,
    required String password,
    deviceToken,
    deviceType,
    deviceName,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = phoneNumber;
    data['password'] = password;
    data['fcmToken'] = 'deviceToken';
    data['platform'] = 'android';
    return data;
  }

  static registerReq({
    required String phoneNumber,
    required String password,
    required String email,
    required String name,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phone'] = phoneNumber;
    return data;
  }

  static forgetReq({required String phoneNumber}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = phoneNumber;
    return data;
  }

  static socialLoginReq({
    var userId,
    var email,
    var fullName,
    var username,
    var provider,
    var img_url,
    var deviceToken,
    var deviceType,
    var deviceName,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['User[userId]'] = userId;
    data['User[email]'] = email;
    data['User[full_name]'] = fullName;
    data['LoginForm[username]'] = username;
    data['LoginForm[provider]'] = provider;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    data['img_url'] = img_url;
    return data;
  }

  static logCrashErrorReq({
    error,
    packageVersion,
    phoneModel,
    ip,
    stackTrace,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }
}
