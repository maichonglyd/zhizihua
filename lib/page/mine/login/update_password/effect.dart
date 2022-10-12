import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/page/home_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<UpdatePasswordState> buildEffect() {
  return combineEffects(<Object, Effect<UpdatePasswordState>>{
    UpdatePasswordAction.action: _onAction,
    UpdatePasswordAction.updatePwd: _updatePwd,
  });
}

void _onAction(Action action, Context<UpdatePasswordState> ctx) {}

void _updatePwd(Action action, Context<UpdatePasswordState> ctx) {
  String oldpwd = ctx.state.oldPwdController.text;
  String newpwd1 = ctx.state.newPwd1Controller.text;
  String newpwd2 = ctx.state.newPwd2Controller.text;

  if (oldpwd.isEmpty) {
    showToast(getText(name: 'toastOldPasswordNotNull'));
    return;
  }

  if (newpwd1.isEmpty || newpwd2.isEmpty) {
    showToast(getText(name: 'toastNewPasswordNotNull'));
    return;
  }

  if (newpwd1 != newpwd2) {
    showToast(getText(name: 'toastNewPasswordNotSame'));
    return;
  }

  UserService.updatePassword(oldpwd, newpwd1).then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastPasswordModifySuccessful'));
      Navigator.of(ctx.context).pop();
      ctx.broadcast(HomeActionCreator.onLoginInvalid(false, true));
    }
  }).catchError((err) {});
}
