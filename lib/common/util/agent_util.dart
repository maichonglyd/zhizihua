import 'dart:convert';

import 'package:flutter_huoshu_app/common/util/sp_util.dart';

class AgentUtil {
  static final String KEY_USER_NAME = "KEY_USER_NAME_AGENT";
  static final String KEY_USER_PW = "KEY_USER_PW_AGENT";
  static final String KEY_USER_USER_INFO = "KEY_USER_USER_INFO";
  static const String KEY_USER_USER_INFO_LIST = "KEY_USER_USER_INFO_LIST";

  static List<String> datas = List();

  static Future saveLoginInfo(String userName, String password) async {
    SpUtil.prefs.setString(KEY_USER_USER_INFO,
        "{'userName':'" + userName + "'," + "'password':'" + password + "}");
    int index = 0;
    for (String item in datas) {
      if (item.contains(userName)) {
        datas.removeAt(index);
        datas.add(
            "{'userName':'" + userName + "'," + "'password':'" + password + "}");
      }else{
        datas.add(
            "{'userName':'" + userName + "'," + "'password':'" + password + "}");
      }
      index++;
    }
    saveUserLoginInfoList(json.encode(datas));
    print("saveUserLoginInfoList${json.encode(datas)}");
  }

  static saveUserLoginInfoList(String json) async {
    SpUtil.prefs.setString(KEY_USER_USER_INFO_LIST, json);
  }

  static Future<String> getUserLoginInfoList() async {
    String data = SpUtil.prefs.getString(KEY_USER_USER_INFO_LIST);
    return Future.value(data);
  }

  static Future saveLoginPW(String password) async {
    SpUtil.prefs.setString(KEY_USER_PW, password);
  }

  static Future saveLoginUserName(String userName) async {
    SpUtil.prefs.setString(KEY_USER_NAME, userName);
  }

  static String getUserName() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getString(KEY_USER_NAME) == null
          ? ""
          : SpUtil.prefs.getString(KEY_USER_NAME);
    } else {
      return "";
    }
  }

  static String getPW() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getString(KEY_USER_PW) == null
          ? ""
          : SpUtil.prefs.getString(KEY_USER_PW);
    } else {
      return "";
    }
  }
}
