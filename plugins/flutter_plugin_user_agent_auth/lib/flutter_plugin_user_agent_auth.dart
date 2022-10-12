import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth_ios.dart';

class FlutterPluginUserAgentAuth {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_user_agent_auth');

  static Future<DeviceBean> get getDeviceInfo async {
    final String deviceInfo = await _channel.invokeMethod('getDeviceInfo');
    try {
      return Future.value(DeviceBean.fromJson(json.decode(deviceInfo)));
    } catch (e) {
      print(e.toString());
    }
    return Future.value(null);
  }

  static Future<List<UserInfo>> get getUserLoginInfoList async {
    if (Platform.isIOS) {
      return IOSUserAgent.getUserLoginInfoList();
    }

    final String data = await _channel.invokeMethod('getUserLoginInfo');
    try {
      var jsonList = json.decode(data);
      List<UserInfo> list = new List();
      jsonList.forEach((v) {
        list.add(new UserInfo.fromJson(v));
      });
      return Future.value(list);
    } catch (e) {
      print(e);
    }
    return Future.value(null);
  }

  static Future<UserInfo> get getUserInfoLast async {
    final String data = await _channel.invokeMethod('getUserInfoLast');
    try {
      return Future.value(UserInfo.fromJson(json.decode(data)));
    } catch (e) {
      print(e.toString());
    }
    return Future.value(null);
  }

  static Future<bool> saveUserLoginInfo(
      String username, String password) async {
//    return IOSUserAgent.saveUserLoginInfo(username, password);
    if (Platform.isIOS) {
      return IOSUserAgent.saveUserLoginInfo(username, password);
    }
    final bool isOk = await _channel.invokeMethod(
        'saveUserLoginInfo', {"username": username, "password": password});
    return Future.value(isOk);
  }

  static Future<bool> deleteUserLoginByName(String username) async {
    final bool isOk = await _channel
        .invokeMethod('deleteUserLoginByName', {"username": username});
    return Future.value(isOk);
  }

  static Future<bool> addOrUpdateAgent(
      String packageName, String installCode, String agent) async {
    final bool isOk = await _channel.invokeMethod('addOrUpdateAgent', {
      "packageName": packageName,
      "installCode": installCode,
      "agent": agent
    });
    return Future.value(isOk);
  }

  static Future<String> get getOaid async {
    final String oaid = await _channel.invokeMethod('getOaid');
    try {
      return Future.value(oaid);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(null);
  }

  static Future init(UserAgentAuthListener userAgentAuthListener) async {
    _channel.setMethodCallHandler((MethodCall call) {
      if (call.method == "initDeviceInfo") {
        try {
          DeviceBean deviceBean =
              DeviceBean.fromJson(json.decode(call.arguments));
          userAgentAuthListener.initDeviceInfo(deviceBean);
        } catch (e) {
          print(e);
          userAgentAuthListener.initDeviceInfo(null);
        }
      } else if (call.method == "nativeInitOK") {
        try {
          HuoInitInfo huoInitInfo =
              HuoInitInfo.fromJson(json.decode(call.arguments));
          userAgentAuthListener.nativeInitOK(huoInitInfo);
        } catch (e) {
          print(e);
          userAgentAuthListener.nativeInitOK(null);
        }
      } else if (call.method == "nativeInitFail") {
        try {
          HuoInitInfo huoInitInfo =
              HuoInitInfo.fromJson(json.decode(call.arguments));
          userAgentAuthListener.nativeInitFail(huoInitInfo);
        } catch (e) {
          print(e);
          userAgentAuthListener.nativeInitFail(null);
        }
      }
      return Future.value(null);
    });
  }

  static Future<bool> getAppInstall(String uri) async {
    Map<String, Object> args = {"uri": uri};
    final Map<dynamic, dynamic> deviceInfo = await _channel.invokeMethod('getAppInstall', args);
    try {
      bool result = deviceInfo['result'];
      return Future.value(result);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(false);
  }


  static Future<Map<String, Object>> finishApp() async {
    final Map<String, Object> map = await _channel.invokeMethod('finishApp');
    return Future.value(map);
  }

  static Future<String> getWebViewUserAgent() async {
    final String userAgent = await _channel.invokeMethod('getWebViewUserAgent');
    return Future.value(userAgent);
  }
}

abstract class UserAgentAuthListener {
  void initDeviceInfo(DeviceBean deviceInfo);

  void nativeInitOK(HuoInitInfo huoInitInfo);

  void nativeInitFail(HuoInitInfo huoInitInfo);
}

class DeviceBean {
  String device_id = "";
  String imei = "";
  String idfv = "";
  String mac = "";
  String hs_agent = "";
  String ip = "";
  String model = "";
  String os = Platform.isIOS ? "ios" : "android";
  String os_version = "";
  String screen = "";
  String net = "";
  String imsi = "";
  String disk_space = "";
  String open_time = "0";
  String is_charge = "0";
  String has_sim = "0";
  String is_break = "0";
  String userua = "";
  String ipaddrid = "";
  String deviceinfo = "";
  String local_ip = "";
  String brand = "";
  String oaid = "";
  String udid = "";

  DeviceBean();

  DeviceBean.fromJson(Map<String, dynamic> json) {
    device_id = json['device_id'];
    imei = json['imei'];
    idfv = json['idfv'];
    mac = json['mac'];
    hs_agent = json['hs_agent'];
    ip = json['ip'];
    model = json['model'];
    os_version = json['os_version'];
    screen = json['screen'];
    net = json['net'];
    imsi = json['imsi'];
    disk_space = json['disk_space'];
    open_time = json['open_time'];
    is_charge = json['is_charge'];
    has_sim = json['has_sim'];
    is_break = json['is_break'];
    userua = json['userua'];
    ipaddrid = json['ipaddrid'];
    deviceinfo = json['deviceinfo'];
    local_ip = json['local_ip'];
    brand = json['brand'];
    oaid = json['oaid'];
    udid = json['udid'];

  }
}

class HuoInitInfo {
  String hs_appid = "";
  String hs_clientid = "";
  String hs_clientkey = "";
  String hs_appkey = "";
  String hs_agent = "";
  String from = "3";
  String base_url = "";
  String base_suffix_url = "";
  String base_ip;
  String project_code;
  String use_url_type;
  String app_packagename;
  String packagename = "";
  String rsa_public_key;

  HuoInitInfo();

  HuoInitInfo.fromJson(Map<String, dynamic> json) {
    hs_appid = json['hs_appid'];
    hs_clientid = json['hs_clientid'];
    hs_clientkey = json['hs_clientkey'];
    hs_agent = json['hs_agent'];
    base_url = json['base_url'];
    base_suffix_url = json['base_suffix_url'];
    base_ip = json['base_ip'];
    project_code = json['project_code'];
    use_url_type = json['use_url_type'];
    app_packagename = json['app_packagename'];
    packagename = json['packagename'];
    rsa_public_key = json['rsa_public_key'];
  }
}

class UserInfo {
  String username;
  String password;

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
