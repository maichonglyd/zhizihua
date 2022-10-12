
import 'dart:convert';

import 'package:flutter_huoshu_app/common/util/sp_util.dart';


class NoPopInfoUtil{
  static const String SP_KEY_NO_POP="sp_key_no_pop";
  static saveData(String data) async {
    (await SpUtil.getSP()).setString(SP_KEY_NO_POP,data);
  }
  static Future<String> getInitInfo() async {
    String data=(await SpUtil.getSP()).getString(SP_KEY_NO_POP);
    if(data!=null&&data.isNotEmpty){
      return data;
    }
    return Future.value(null);
  }


}