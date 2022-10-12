import 'dart:convert';

import 'package:flutter_huoshu_app/common/util/sp_util.dart';

class ComeRechargeFirstComeUtil {
  static const String SP_KEY_RECHARGE = "sp_key_come_recharge";

  static saveInfo(bool isFirst) async {
    (await SpUtil.getSP()).setBool(SP_KEY_RECHARGE, isFirst);
  }

  static Future<bool> getSaveInfo() async {
    bool isFirstCome = (await SpUtil.getSP()).getBool(SP_KEY_RECHARGE);
    return isFirstCome;
  }
}
