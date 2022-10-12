import 'dart:convert';

import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

class UpdateUtil {
  static const String SP_KEY_SPLASH = "sp_key_splash";
  static saveSplash(Splash splash) async {
    (await SpUtil.getSP())
        .setString(SP_KEY_SPLASH, json.encode(splash.toJson()));
  }

  static Future<Splash> getSplashInfo() async {
    String jsonStr = (await SpUtil.getSP()).getString(SP_KEY_SPLASH);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      return Splash.fromJson(json.decode(jsonStr));
    }
    return Future.value(null);
  }
}
