import 'dart:convert';

import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:flutter_huoshu_app/common/util/agent_util.dart';

class IOSUserAgent {
  static Future<List<UserInfo>> getUserLoginInfoList() async {
    final String data = await AgentUtil.getUserLoginInfoList();
    print("data#############:${data.toString()}");
    try {
      var jsonList = json.decode(data);
      List<UserInfo> list = new List();
      jsonList.forEach((v) {
        list.add(new UserInfo.fromJson(v));
      });
      print("jsonList:${list.toString()}");
      return Future.value(list);
    } catch (e) {
      print(e);
    }
    return Future.value(null);
  }

  static Future<bool> saveUserLoginInfo(
      String username, String password) async {
//    await AgentUtil.saveLoginUserName(username);
//    await AgentUtil.saveLoginPW(password);
    await AgentUtil.saveLoginInfo(username,password);
    return Future.value(true);
  }

}
