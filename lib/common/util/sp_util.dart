import 'package:shared_preferences/shared_preferences.dart';

/// @author liu hong liang
/// @date 2019/8/25
/// sp初始化类
///
///

class SpUtil{
  static SharedPreferences prefs;

  static final String NEED_CHANGE_URL = "NEED_CHANGE_URL";
  static final String BASE_URL = "BASE_URL";
  static final String APP_ID = "APP_ID";
  static final String IOS_APP_ID = "IOS_APP_ID";
  static final String CLIENT_ID = "CLIENT_ID";
  static final String CLIENT_KEY = "CLIENT_KEY";
  static final String RSA_KEY = "RSA_KEY";
  static final String PERMISSION_PHONE_LAST_TIME = "PERMISSION_PHONE_LAST_TIME";
  static final String SAVE_LOCAL = "SAVE_LOCAL";

  static Future init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }
  static Future<SharedPreferences> getSP() async {
    return SharedPreferences.getInstance();
  }
}