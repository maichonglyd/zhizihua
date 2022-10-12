import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Timer _timer;

Effect<BindMobileState> buildEffect() {
  return combineEffects(<Object, Effect<BindMobileState>>{
    BindMobileAction.action: _onAction,
    BindMobileAction.sendSms: _sendSMS,
    BindMobileAction.bindMobile: _bindMobile,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<BindMobileState> ctx) {}
void _dispose(Action action, Context<BindMobileState> ctx) {
  if (_timer != null) {
    _timer.cancel();
    _timer = null;
  }
}

void _bindMobile(Action action, Context<BindMobileState> ctx) {
  String mobile = ctx.state.mobileController.text;
  String code = ctx.state.codeController.text;
  if (mobile.isEmpty) {
    showToast(getText(name: 'toastMobilePhoneNotNull'));
    return;
  }
  if (code.isEmpty) {
    showToast(getText(name: 'toastVerCodeNotNull'));
    return;
  }

  UserService.bindMobile(mobile, code).then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastBindSuccessful'));
      ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      Navigator.of(ctx.context).pop();
    }
  }).catchError((err) {
    print(err);
  });
}

void _sendSMS(Action action, Context<BindMobileState> ctx) {
  String mobile = ctx.state.mobileController.text;
  int count = ctx.state.countdownTime;
  if (mobile.isNotEmpty) {
    //请求发送短信接口
    UserService.sendBindSms(mobile).then((data) {
      //对数据解析 重构才计数
      //启动定时器  计数
      const oneSec = const Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (timer) {
        if (count > 1) {
          ctx.dispatch(BindMobileActionCreator.updateDownTime(--count));
        } else {
          ctx.dispatch(BindMobileActionCreator.updateDownTime(120));
          _timer.cancel();
        }
      });
    }).catchError((err) {
      showToast(getText(name: 'toastError'));
      print(err);
    });
  } else {
    showToast(getText(name: 'toastMobilePhoneNotNull'));
    //提示用户
  }
}
