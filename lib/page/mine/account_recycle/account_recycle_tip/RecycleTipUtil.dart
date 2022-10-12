import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';

import 'page.dart';

class RecycleTipUtil {
  static final String KEY_RECYCLE_TIP = "KEY_RECYCLE_TIP"; //弹出小号回收的提升框

  static bool getValue() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getBool(KEY_RECYCLE_TIP) == null
          ? true
          : SpUtil.prefs.getBool(KEY_RECYCLE_TIP);
    } else {
      return true;
    }
  }

  static bool saveValue(bool isOpen) {
    SpUtil.prefs.setBool(KEY_RECYCLE_TIP, isOpen);
  }

  static void showTip(BuildContext context) {
    if (getValue()) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        saveValue(false);
        timer.cancel();
        showDialog(
            context: context,
            builder: (context) {
              return AccountRecycleTipPage().buildPage({});
            },
            barrierDismissible: false);
      });
    }
  }
}
