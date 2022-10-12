import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/bind_mobile/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/update_password/page.dart';
import 'package:flutter_huoshu_app/page/mine/update_mobile/page.dart';
import 'action.dart';
import 'state.dart';

Effect<SecurityState> buildEffect() {
  return combineEffects(<Object, Effect<SecurityState>>{
    SecurityAction.action: _onAction,
    SecurityAction.gotoUpdatePassword: _gotoUpdatePassword,
    SecurityAction.gotoUpdateMobile: _gotoUpdateMobile,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<SecurityState> ctx) {}

void _gotoUpdatePassword(Action action, Context<SecurityState> ctx) {
  AppUtil.gotoPageByName(ctx.context, UpdatePasswordPage.pageName,
      arguments: null);
}

void _gotoUpdateMobile(Action action, Context<SecurityState> ctx) {
  UserInfo userInfo = LoginControl.getUserInfo();
  if (userInfo != null &&
      userInfo.data != null &&
      userInfo.data.mobile != null &&
      userInfo.data.mobile.isNotEmpty) {
    AppUtil.gotoPageByName(ctx.context, UpdateMobilePage.pageName,
        arguments: userInfo.data.mobile);
  } else {
    AppUtil.gotoPageByName(ctx.context, BindMobilePage.pageName);
  }
}

void _init(Action action, Context<SecurityState> ctx) {
  UserService.getServiceInfo().then((data) {
    if (data.code == 200) {
      ctx.dispatch(SecurityActionCreator.update(data));
    }
  });
}
