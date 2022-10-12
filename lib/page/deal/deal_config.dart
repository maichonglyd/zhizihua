import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @author liu hong liang
/// @date 2019/8/25
/// 小号交易配置
///
class DealConfig {
  static const String SP_KEY_FEE_RATE = "SP_KEY_FEE_RATE"; //	Number	交易费率（%）	5
  static const String SP_KEY_MIN_FEE = "SP_KEY_MIN_FEE"; //	Number	最低手续费	5
  static const String SP_KEY_MIN_PRICE = "SP_KEY_MIN_PRICE"; //	Number	最低交易金额	6

  static const String SP_KEY_PROP_FEE_RATE =
      "SP_KEY_PROP_FEE_RATE"; //	Number	交易费率（%）	5
  static const String SP_KEY_PROP_MIN_FEE =
      "SP_KEY_PROP_MIN_FEE"; //	Number	最低手续费	5
  static const String SP_KEY_PROP_MIN_PRICE =
      "SP_KEY_PROP_MIN_PRICE"; //	Number	最低交易金额	6

  static num getValue(String key, num defaultValue) {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.get(key) == null
          ? defaultValue
          : SpUtil.prefs.get(key);
    } else {
      return defaultValue;
    }
  }

  static void saveValue(String key, num value) {
    SpUtil.prefs.setDouble(key, value.toDouble());
  }
}
