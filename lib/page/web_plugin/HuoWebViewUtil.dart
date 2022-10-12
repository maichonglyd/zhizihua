import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/action.dart';
import 'package:flutter_huoshu_app/page/web_plugin/state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HuoWebViewUtil {
  Context<WebPageState> ctx;
  static const String NATIVE_OBJECT = "huo";
  Map<String, dynamic> jsApi = {};

  static NavigationDecision huoNavigationDelegate(
      NavigationRequest navigation, WebPageState state) {
//    print("huoNavigationDelegate: ${navigation.url}");
//    if(navigation.url.startsWith("https://wx.tenpay.com")&& Platform.isAndroid){
//      state.webViewController.loadUrl(navigation.url,headers: {"Referer":RequestUtil.urlAppendCommonParams(state.url)});
//      return NavigationDecision.prevent;
//    }
//    else if (navigation.url.startsWith("https:") ||
//        navigation.url.startsWith("http:") ||
//        navigation.url.startsWith("ftp:")) {
//      return NavigationDecision.navigate;
//    } else  {
//      try {
//        print("launch：${navigation.url}");
//        launch(navigation.url);
//        return NavigationDecision.prevent;
//      } catch (e) {
//        print(e);
//        return NavigationDecision.navigate;
//      }
//    }
  }

  HuoWebViewUtil(this.ctx) {
    //监听网页url变动
    //todo by liuhongliang 无法拦截，无法添加内容
    //    if(navigation.url.startsWith("https://wx.tenpay.com")&& Platform.isAndroid){
//      state.webViewController.loadUrl(navigation.url,headers: {"Referer":RequestUtil.urlAppendCommonParams(state.url)});
//      return NavigationDecision.prevent;
//    }
    ctx.state.flutterWebViewPlugin.onUrlChanged.listen((String url) async {
      print("huotest url is $url");
      if (url.startsWith("weixin://")){
        print("huotest url start with weixin://");
        await ctx.state.flutterWebViewPlugin.stopLoading();
        await ctx.state.flutterWebViewPlugin.goBack();
        if (await canLaunch(url)) {
          await ctx.state.flutterWebViewPlugin.launch(url);
          return;
        }
        print("couldn't launch $url");
      }
      if (!url.startsWith("https:") &&
          !url.startsWith("http:") &&
          !url.startsWith("ftp:")) {
        try {
          print("launch：${url}");
          ctx.state.flutterWebViewPlugin.launch(url);
        } catch (e) {
          print(e);
        }
      }else {
        ctx.state.flutterWebViewPlugin.launch(url);
      }
    });

    jsApi["getInitData"] = () {
      jsApi["getToken"]();
      jsApi["getEnvironment"]();
      jsApi["getAppId"]();
    };
    jsApi["getToken"] = () {
      ctx.state.flutterWebViewPlugin
          .evalJavascript(
              "HuoNativeApi.callBack.setToken('${LoginControl.getToken()}')")
          .then((result) {
        print("设置token:" + result);
      });
    };
    jsApi["getEnvironment"] = () {
      String deviceType =
          Platform.isAndroid ? "flutter_andapp" : "flutter_iosapp";
      ctx.state.flutterWebViewPlugin
          .evalJavascript(
              "HuoNativeApi.callBack.setEnvironment('${deviceType}')")
          .then((result) {
        print("设置Environment:" + result);
      });
    };
    jsApi["getAppId"] = () {
      ctx.state.flutterWebViewPlugin
          .evalJavascript(
              "HuoNativeApi.callBack.setAppId(${Platform.isAndroid ? AppConfig.appid : AppConfig.iosAppid})")
          .then((result) {
        print("设置AppId:" + result);
      });
    };
    jsApi["closeWeb"] = () {
      Navigator.pop(ctx.context);
      ctx.state.flutterWebViewPlugin.close();
    };
    jsApi["closeUI"] = () {
      Navigator.pop(ctx.context);
      ctx.state.flutterWebViewPlugin.close();
    };
    jsApi["login"] = () {
      print("login");
      ctx.state.flutterWebViewPlugin.hide();
      AppUtil.gotoPageByName(ctx.context, LoginPage.pageName).then((data) {
        if (!LoginControl.isLogin()) {
          Navigator.pop(ctx.context);
          ctx.state.flutterWebViewPlugin.close();
        } else {
          ctx.state.flutterWebViewPlugin.show();
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
