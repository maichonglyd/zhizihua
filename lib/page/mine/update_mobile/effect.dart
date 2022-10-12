import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/mine/bind_mobile/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Timer _timer;

Effect<UpdateMobileState> buildEffect() {
  return combineEffects(<Object, Effect<UpdateMobileState>>{
    UpdateMobileAction.action: _onAction,
    UpdateMobileAction.sendSms: _sendSMS,
    UpdateMobileAction.checkMobile: _checkMobile,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<UpdateMobileState> ctx) {}

void _dispose(Action action, Context<UpdateMobileState> ctx) {
  if (_timer != null) {
    _timer.cancel();
    _timer = null;
  }
}

void _checkMobile(Action action, Context<UpdateMobileState> ctx) {
  String code = ctx.state.codeController.text;
  if (code.isEmpty) {
    showToast(getText(name: 'textCodeNotNull'));
    return;
  }

  UserService.sendMobileCheck(code).then((data) {
    if (data['code'] == 200) {
      //成功进入绑定手机号
      Navigator.of(ctx.context).pop();
      AppUtil.gotoPageByName(ctx.context, BindMobilePage.pageName);
    }
  }).catchError((err) {});
}

void _sendSMS(Action action, Context<UpdateMobileState> ctx) {
  int count = ctx.state.countdownTime;
//  if (mobile.isNotEmpty) {
  //请求发送短信接口
  UserService.sendResetMobileSms().then((data) {
    if (data['code'] == 200) {
      //对数据解析 重构才计数
      //启动定时器  计数
      const oneSec = const Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (timer) {
        if (count > 1) {
          ctx.dispatch(UpdateMobileActionCreator.updateDownTime(--count));
        } else {
          ctx.dispatch(UpdateMobileActionCreator.updateDownTime(120));
          _timer.cancel();
        }
      });
    }
  }).catchError((err) {
    print(err);
  });
//  } else {
//    showToast("手机号不可以为空");
//    //提示用户
//  }
}
