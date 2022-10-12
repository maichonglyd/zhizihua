import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/Login/register_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/find_password/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart' as user_info;
import 'package:oktoast/oktoast.dart';

import 'state.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.initState: _init,
    Lifecycle.didChangeDependencies: _didChangeDependencies,
    LoginAction.onLogin: _onLogin,
    LoginAction.gotoRegister: _gotoRegister,
    LoginAction.gotoFindPassword: _gotoFindPassword,
    Lifecycle.didUpdateWidget: _didUpdateWidget
  });
}

void _didUpdateWidget(Action action, Context<LoginState> ctx) {
  print("_didUpdateWidget");
//      HuoVideoManager.pauseByType(HuoVideoManager.type_video);
}

void _didChangeDependencies(Action action, Context<LoginState> ctx) {}

void _init(Action action, Context<LoginState> ctx) {
  LoginControl.saveLogin(false);
  ctx.broadcast(LoginActionCreator.logout());
  //ios 没有本地存储，暂时适用sp来存储登录数据，同步到安卓数据库即可
//  FlutterPluginUserAgentAuth.getUserInfoLast.then((UserInfo userInfo) {
//    println("获取到的userinfo:" + userInfo.username);
//    if (userInfo != null) {
//      ctx.dispatch(LoginActionCreator.updateLastLoginUser(userInfo));
//    }
//  });
}

void _onLogin(Action action, Context<LoginState> ctx) {
  String username = ctx.state.mobileController.text;
  String password = ctx.state.passwordController.text;
  print("用户名为：" + username);
  print("密码：" + password);

  if (username.isNotEmpty && password != null) {
    UserService.usernameLogin(username, password, ctx)
        .then((user_info.UserInfo data) {
      if (data.code == 200) {
        LoginControl.saveLogin(true);
        LoginControl.saveRegister(false);
        LoginControl.saveToken(data.data.token);
        LoginControl.saveLoginPW(password);
        LoginControl.saveLoginUserName(username);
        FlutterPluginUserAgentAuth.saveUserLoginInfo(username, password);
        //发送登录成功广播
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
        ctx.broadcast(LoginActionCreator.loginOK());
        ctx.broadcast(HomeActionCreator.showCouponDialog());
        Navigator.pop(ctx.stfState.context);
      }
    });
  } else {
    showToast(getText(name: 'toastUsernameAndPasswordNotNull'));
  }
}

void _gotoRegister(Action action, Context<LoginState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RegisterPage.pageName, arguments: null);
}

void _gotoFindPassword(Action action, Context<LoginState> ctx) {
  AppUtil.gotoPageByName(ctx.context, FindPasswordPage.pageName,
      arguments: null);
}
