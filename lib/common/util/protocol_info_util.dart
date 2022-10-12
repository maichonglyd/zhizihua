
import 'dart:convert';

import 'package:flutter_huoshu_app/common/util/sp_util.dart';


class ProtocolInfoUtil{
  static const String SP_KEY_PROTOCOL="sp_key_protocol";
  static const String SP_KEY_COUPON="SP_KEY_COUPON";

  static saveData(String data) async {
    (await SpUtil.getSP()).setString(SP_KEY_PROTOCOL,data);
  }
  static Future<String> getInitInfo() async {
    String data=(await SpUtil.getSP()).getString(SP_KEY_PROTOCOL);
    if(data!=null&&data.isNotEmpty){
      return data;
    }
    return Future.value(null);
  }

  static saveIsFirst(bool data) async {
    (await SpUtil.getSP()).setBool(SP_KEY_COUPON,data);
  }
  static Future<bool> getIsFirst() async {
    bool data=(await SpUtil.getSP()).getBool(SP_KEY_COUPON);
    if(data!=null){
      return data;
    }
    return Future.value(true);
  }


}