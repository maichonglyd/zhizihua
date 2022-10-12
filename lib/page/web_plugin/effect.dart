import 'dart:convert';
import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/web_plugin/HuoWebViewUtil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:orientation/orientation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<WebPageState> buildEffect() {
  return combineEffects(<Object, Effect<WebPageState>>{
    Lifecycle.initState: _initState,
    LoginAction.loginOK: _loginOK,
    WebPageAction.onWebViewCreated: _onWebViewCreated,
    Lifecycle.dispose: _dispose,
//    Lifecycle.didUpdateWidget:_didUpdateWidget,
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
        }
      });
}

void _dispose(Action action, Context<WebPageState> ctx) {
  HuoLog.d("=======_dispose=========");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //强制竖屏
  OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
//  ctx.state.webViewController.clearCache();
}

String createUserAgent(Context<WebPageState> ctx) {
  Map<String, dynamic> userAgentMap = {
    "environment": Platform.isAndroid ? "flutter_andapp" : "flutter_iosapp",
    "appId": AppConfig.appid,
    "token": LoginControl.getToken()
  };

  print("userAgent:#data=" + json.encode(userAgentMap));
  return "#data=" + json.encode(userAgentMap);
}

void _onWebViewCreated(Action action, Context<WebPageState> ctx) {}

void _onPageFinished(Action action, Context<WebPageState> ctx) {
  ctx.state.isPageFinish = true;
  print("加载完成:" + action.payload);
}
