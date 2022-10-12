import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/action.dart';
import 'package:flutter_huoshu_app/page/web/state.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HuoWebViewUtil {
  Context<WebPageState> ctx;
  static const String NATIVE_OBJECT = "huo";
  Map<String, dynamic> jsApi = {};

  static NavigationDecision huoNavigationDelegate(
      NavigationRequest navigation, WebPageState state) {
    print("huoNavigationDelegate: ${navigation.url}");
    print("url: " + RequestUtil.urlAppendCommonParams(state.url));
    if (navigation.url.startsWith("https://wx.tenpay.com") &&
        Platform.isAndroid) {
      state.webViewController.loadUrl(navigation.url,
          headers: {"Referer": RequestUtil.urlAppendCommonParams(state.url)});
      return NavigationDecision.prevent;
    } else if (navigation.url.startsWith("https:") ||
        navigation.url.startsWith("http:") ||
        navigation.url.startsWith("ftp:")) {
      return NavigationDecision.navigate;
    } else if (navigation.url.startsWith("weixin://")){
      print("huotest launch weixin");
      if (canLaunch(navigation.url) != null){
        launch(navigation.url);
      }
   //     state.webViewController.goBack();
        return NavigationDecision.prevent;
    } else {
      try {
        print("launch：${navigation.url}");
        launch(navigation.url);
        return NavigationDecision.prevent;
      } catch (e) {
        print(e);
        return NavigationDecision.navigate;
      }
    }
  }

  HuoWebViewUtil(this.ctx) {
    jsApi["getInitData"] = () {
      jsApi["getToken"]();
      jsApi["getEnvironment"]();
      jsApi["getAppId"]();
    };
    jsApi["getToken"] = () {
      ctx.state.webViewController
          .evaluateJavascript(
              "HuoNativeApi.callBack.setToken('${LoginControl.getToken()}')")
          .then((result) {
        print("设置token:" + result);
      });
    };
    jsApi["getEnvironment"] = () {
      String deviceType =
          Platform.isAndroid ? "flutter_andapp" : "flutter_iosapp";
      ctx.state.webViewController
          .evaluateJavascript(
              "HuoNativeApi.callBack.setEnvironment('${deviceType}')")
          .then((result) {
        print("设置Environment:" + result);
      });
    };
    jsApi["getAppId"] = () {
      ctx.state.webViewController
          .evaluateJavascript(
              "HuoNativeApi.callBack.setAppId(${Platform.isAndroid ? AppConfig.appid : AppConfig.iosAppid})")
          .then((result) {
        print("设置AppId:" + result);
      });
    };
//    jsApi["innerWeb"] = (token) {
//      //打开一个新的网页
////      launch(token);
//      AppUtil.gotoH5Web(ctx.context, token, title: "支付")
//          .then((d) {
//            //这里调用h5方法查单
////        queryOrder(data.data.orderId, ctx);
//      });
//    };
    jsApi["closeWeb"] = () {
      print("logcat: closeWeb");
      Navigator.pop(ctx.context);
//      showToast("调用closeWeb");
    };
    jsApi["closeUI"] = () {
      Navigator.pop(ctx.context);
    };
    jsApi["login"] = () {
      print("login");

      AppUtil.gotoPageByName(ctx.context, LoginPage.pageName).then((data) {
        if (!LoginControl.isLogin()) {
          Navigator.pop(ctx.context);
        }
      });
    };
    jsApi["setIdentify"] = () {
      ctx.broadcast(AccountManageActionCreator.getUserInfo());
    };
    jsApi["changeAccount"] = () {
      AppUtil.gotoPageByName(ctx.context, LoginPage.pageName).then((data) {
        if (!LoginControl.isLogin()) {
          Navigator.pop(ctx.context);
        }
      });
    };
  }
}
