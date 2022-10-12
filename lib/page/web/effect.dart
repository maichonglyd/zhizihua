import 'dart:convert';
import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/web/HuoWebViewUtil.dart';
import 'package:flutter_huoshu_app/widget/dialog/NormalTipsDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:orientation/orientation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'action.dart';
import 'state.dart';

Effect<WebPageState> buildEffect() {
  return combineEffects(<Object, Effect<WebPageState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    LoginAction.loginOK: _loginOK,
    WebPageAction.onWebViewCreated: _onWebViewCreated,
    WebPageAction.onPageFinished: _onPageFinished,
    WebPageAction.showPopPageDialog: _showPopPageDialog,
  });
}

void _loginOK(Action action, Context<WebPageState> ctx) {
  //登录成功后刷新游戏页面
 ctx.dispatch(WebPageActionCreator.updateUserAgent(createUserAgent(ctx)));
}

void _initState(Action action, Context<WebPageState> ctx) {
  ctx.state.userAgent = createUserAgent(ctx);

  HuoWebViewUtil huoJavascriptHandler = new HuoWebViewUtil(ctx);
  ctx.state.javascriptChannel = new JavascriptChannel(
      name: HuoWebViewUtil.NATIVE_OBJECT,
      onMessageReceived: (JavascriptMessage message) {
//        showToast(message.message);
        print("js调用：" + message.message);

        Map<String, dynamic> data = null;
        try {
          data = json.decode(message.message);
          if (data.containsKey("method")) {}
        } catch (e) {
          print(e);
        }
        if (data == null || !data.containsKey("method")) {
          return;
        }
        if (huoJavascriptHandler.jsApi.containsKey(data['method'])) {
          huoJavascriptHandler.jsApi[data['method']]();
          return;
        }
        //其他方法处理
        switch (data['method']) {
          case "showToast":
            showToast(data['params']);
            break;
          case "outWeb":
            if (null != data['params'] && null != data['params']['url']) {
              String url = data['params']['url'].toString();
              launch(url);
            }
            break;
          case 'openWechat':
            try {
              launch("weixin://");
            } catch (e) {
              print(e);
            }
            break;
        }
      });
}

void _dispose(Action action, Context<WebPageState> ctx) {
  HuoLog.d("=======_dispose=========");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //强制竖屏
  OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  //恢复状态栏显示
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

///这里#data=数据前面的#去掉,不然调不起来支付,#是后台截取数据用到的,这里要跟后台沟通一下
String createUserAgent(Context<WebPageState> ctx) {
  String webViewUserAgent = DeviceInfoUtil.webViewUserAgent;
  Map<String, dynamic> userAgentMap = {
    "environment": Platform.isAndroid ? "flutter_andapp" : "flutter_iosapp",
    "appId": AppConfig.appid,
    "token": LoginControl.getToken()
  };
  print("userAgent:${webViewUserAgent}data=" + json.encode(userAgentMap));
  return webViewUserAgent + "data=" + json.encode(userAgentMap);
}

void _onWebViewCreated(Action action, Context<WebPageState> ctx) {
  print("========onWebViewCreated===========");
  ctx.state.webViewController = action.payload;
  //  doing something
}

void _onPageFinished(Action action, Context<WebPageState> ctx) {
  ctx.state.isPageFinish = true;
  print("加载完成:" + action.payload);
}

void _showPopPageDialog(Action action, Context<WebPageState> ctx) {
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return NormalTipsDialog(
              cancelCallback: () {},
              confirmCallback: () {
                Navigator.pop(ctx.context); // 退出
              },
            );
          },
        );
      });
}
