import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/page/mine/Login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_feedback/page.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/page/update/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/ChangeUrlDialog.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>>{
    SettingAction.action: _onAction,
    SettingAction.gotoFeedback: _gotoFeedback,
    SettingAction.gotoAccountManage: _gotoAccountManage,
    SettingAction.logout: _logout,
    Lifecycle.initState: _init,
    SettingAction.clearCache: _clearCache,
    SettingAction.changUrl: _changeUrl,
  });
}

void _onAction(Action action, Context<SettingState> ctx) {}

void _clearCache(Action action, Context<SettingState> ctx) {
  AppUtil.clearCache().then((cacheSize) {
    ctx.dispatch(SettingActionCreator.updateCacheSize(cacheSize));
  });
}

void _init(Action action, Context<SettingState> ctx) {
  AppUtil.loadCache().then((cacheSize) {
    ctx.dispatch(SettingActionCreator.updateCacheSize(cacheSize));
  });
}

void _gotoFeedback(Action action, Context<SettingState> ctx) {
  AppUtil.gotoPageByName(ctx.context, FeedbackPage.pageName, arguments: null);
}

void _gotoAccountManage(Action action, Context<SettingState> ctx) {
  AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName);
}

void _logout(Action action, Context<SettingState> ctx) {
  LoginControl.saveLogin(false);
  Navigator.pop(ctx.context);
  AppUtil.gotoPageByName(ctx.context, LoginPage.pageName, arguments: null)
      .then((data) {
    //登录成功之后,刷新一下用户详情,这里只能发广播进行更新
    ctx.broadcast(MineFragmentActionCreator.getUserInfo());
  });
  UserService.logout().then((data) {});
}

void _changeUrl(Action action, Context<SettingState> ctx) {
  ctx.state.clickCount++;
  if (ctx.state.clickCount < 10) {
    return;
  }
  ctx.state.clickCount = 0;
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return ChangeUrlDialog();
          },
        );
      });
}
