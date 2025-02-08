

// Project imports:
class AuthRequestModel {
  static loginReq({String? email, String? password, deviceToken,deviceType,deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = email;
    data['Password'] = password;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    return data;
  }

  static forgetReq({String? email}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = email;
    return data;
  }

  static socialLoginReq(
      {var userId,
        var email,
        var fullName,
        var username,
        var provider,
        var img_url,
        var deviceToken,
        var deviceType,
        var deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  static logCrashErrorReq({error, packageVersion, phoneModel, ip, stackTrace, }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }

}
