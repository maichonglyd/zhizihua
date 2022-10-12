import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart' as user_info;
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/page/home_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';

Timer _timer;

Effect<RegisterPageState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterPageState>>{
    RegisterPageAction.action: _onAction,
    RegisterPageAction.sendSMS: _sendSMS,
    RegisterPageAction.usernameRegister: _usernameRegister,
    RegisterPageAction.mobileRegister: _mobileRegister,
    RegisterPageAction.gotoRegisterAgreement: _gotoRegisterAgreement,
    Lifecycle.dispose: _disPose
  });
}

void _onAction(Action action, Context<RegisterPageState> ctx) {}

void _gotoRegisterAgreement(Action action, Context<RegisterPageState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textRegisterAgreement'),
    "url": AppConfig.baseUrl + "app/reg/agreement"
  });
}

void _disPose(Action action, Context<RegisterPageState> ctx) {
  if (_timer != null) {
    _timer.cancel();
    _timer = null;
  }
}

void _usernameRegister(Action action, Context<RegisterPageState> ctx) {
  String username = ctx.state.userNameController.text;
  String password = ctx.state.passwordController.text;

  if (username.isEmpty) {
    showToast(getText(name: 'textUserNameNotNull'));
    return;
  }

  if (username.length < 6 || username.length > 12) {
    showToast(getText(name: 'textUsernameSixLetter'));
    return;
  }
  if (password.isEmpty) {
    showToast(getText(name: 'textPasswordNotNull'));
    return;
  }
  if (username.isNotEmpty && password.isNotEmpty) {
    UserService.usernameRegister(username, password)
        .then((user_info.UserInfo data) {
      if (data.code == 200) {
        //注册成功
        showToast(getText(name: 'toastRegisterSuccessful'));
        LoginControl.saveLogin(true);
        LoginControl.saveRegister(true);
        LoginControl.saveToken(data.data.token);
        LoginControl.saveLoginPW(password);
        LoginControl.saveLoginUserName(username);
        FlutterPluginUserAgentAuth.saveUserLoginInfo(username, password);
        //发送登录成功广播
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
        ctx.broadcast(LoginActionCreator.loginOK());
        ctx.broadcast(HomeActionCreator.showCouponDialog());
        Navigator.popUntil(
          ctx.context,
          ModalRoute.withName(Navigator.defaultRouteName),
        );
//        用如下方法会报错：
//         'package:flutter/src/widgets/navigator.dart': Failed assertion: line 2216 pos 12: '!_debugLocked':
//        主要是name参数的格式是要/开头的  例如"/home"
//        Navigator.of(ctx.stfState.context).popUntil(ModalRoute.withName(HomePage.pageName));
      }
    }).catchError((err) {
      showToast(getText(name: 'toastError'));
      print(err);
    });
  }
}

void _mobileRegister(Action action, Context<RegisterPageState> ctx) {
  String mobile = ctx.state.mobileController.text;
  String code = ctx.state.authcodeController.text;
  String password = ctx.state.passwordController.text;
  if (mobile.isEmpty) {
    showToast(getText(name: 'toastMobilePhoneNotNull'));
    return;
  }
  if (code.isEmpty) {
    showToast(getText(name: 'toastVerCodeNotNull'));
    return;
  }
  if (password.isEmpty) {
    showToast(getText(name: 'textPasswordNotNull'));
    return;
  }
  if (mobile.isNotEmpty && password.isNotEmpty && code.isNotEmpty) {
    UserService.mobileRegister(mobile, code, password)
        .then((user_info.UserInfo data) {
      if (data.code == 200) {
        //注册成功
        showToast(getText(name: 'toastRegisterSuccessful'));
        LoginControl.saveLogin(true);
        LoginControl.saveRegister(true);
        LoginControl.saveToken(data.data.token);
        LoginControl.saveLoginPW(password);
        LoginControl.saveLoginUserName(mobile);
        FlutterPluginUserAgentAuth.saveUserLoginInfo(mobile, password);
        //发送登录成功广播
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
        ctx.broadcast(LoginActionCreator.loginOK());
        ctx.broadcast(HomeActionCreator.showCouponDialog());
        Navigator.popUntil(
          ctx.context,
          ModalRoute.withName(Navigator.defaultRouteName),
        );
      }
    }).catchError((err) {
      showToast(getText(name: 'toastError'));
      print(err);
    });
  }
}

void _sendSMS(Action action, Context<RegisterPageState> ctx) {
  String mobile = ctx.state.mobileController.text;
  int count = ctx.state.countdownTime;
  if (mobile.isNotEmpty) {
    //请求发送短信接口
    UserService.sendRegisterSms(mobile).then((data) {
      //对数据解析 重构才计数
      //启动定时器  计数
      if (data['code'] == 200) {
        const oneSec = const Duration(seconds: 1);
        _timer = Timer.periodic(oneSec, (timer) {
          if (count > 1) {
            ctx.dispatch(RegisterPageActionCreator.updateDownTime(--count));
          } else {
            ctx.dispatch(RegisterPageActionCreator.updateDownTime(120));
            _timer.cancel();
          }
        });
      }
    }).catchError((err) {
      showToast(getText(name: 'toastError'));
      print(err);
    });
  } else {
    showToast(getText(name: 'toastMobilePhoneNotNull'));
    //提示用户
  }
}
