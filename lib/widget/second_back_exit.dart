import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/toast_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:oktoast/oktoast.dart';

DateTime _lastPressedAdt; //上次点击时间 初始化的时候是空，下面会做判断
Widget secondBackExitWrapper(BuildContext context, Widget child) {
  return Builder(
      builder: (context) => WillPopScope(
            child: child,
            onWillPop: () async {
              //当_lastPressedAdt 为空说明是第一次点击
              // 当Date.now().different(_lastPressAdt) 是比较当前时间和上一次点击的时间，如果差距小于1秒钟
              //当满足这两种情况的时候，说明这个可能是意外点击到了返回按钮，在这里我们返回flase，表示不响应
              if (_lastPressedAdt == null ||
                  DateTime.now().difference(_lastPressedAdt) >
                      Duration(seconds: 1)) {
                //两次点击时间间隔超过1秒则重新计时
                _lastPressedAdt = DateTime.now();
                ToastUtil.showSelfToast(getText(name: 'textLogoutAfterClickAgain'),
                    position: ToastPosition.center,
                    padding: 10,
                    backgroundColor: Color(0xb2000000));
                return false;
              }
              //添加原因：在视频模块下快速双击退出APP，声音还在播放，所以使用安卓原生方法结束进程
              FlutterPluginUserAgentAuth.finishApp();
              return true;
            },
          ));
}
