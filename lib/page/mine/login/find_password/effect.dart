import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/mine/service/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Timer _timer;

Effect<FindPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<FindPasswordState>>{
    FindPasswordAction.action: _onAction,
    FindPasswordAction.getBindInfo: _getBindInfo,
    FindPasswordAction.sendSms: _sendSms,
    FindPasswordAction.passwordVerify: _passwordVerify,
    FindPasswordAction.passwordReset: _passwordReset,
    FindPasswordAction.commitData: _commitData,
    FindPasswordAction.gotoServer: _gotoServer,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<FindPasswordState> ctx) {}
void _gotoServer(Action action, Context<FindPasswordState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ServicePage.pageName);
}

void _dispose(Action action, Context<FindPasswordState> ctx) {
  if (_timer != null) {
    _timer.cancel();
    _timer = null;
  }
}

void _getBindInfo(Action action, Context<FindPasswordState> ctx) {
  String userName = ctx.state.userNameController.text;
  if (userName.isNotEmpty) {
    UserService.getUserBindInfo(userName).then((data) {
      if (data['code'] == 200 && data['data']['mobile'] != null) {
        ctx.dispatch(FindPasswordActionCreator.nextStep({
          "mobile": data['data']['mobile'],
          "verify_token": data['data']['verify_token']
        }));
      } else {
        //没有绑定手机  弹窗提示  前往客服
      }
    }).catchError((err) {});
  } else {
    showToast(getText(name: 'toastInputUsernameAndPhone'));
  }
}

void _sendSms(Action action, Context<FindPasswordState> ctx) {
  String mobile = ctx.state.bindMobile;
  int count = ctx.state.countdownTime;
  String verifyToken = ctx.state.verifyToken;
  if (mobile.isNotEmpty) {
    //请求发送短信接口
    UserService.sendFindPasswordSms(verifyToken).then((data) {
      if (data['code'] == 200) {
        //对数据解析 重构才计数
        //启动定时器  计数
        const oneSec = const Duration(seconds: 1);
        _timer = Timer.periodic(oneSec, (timer) {
          if (count > 1) {
            ctx.dispatch(FindPasswordActionCreator.updateDownTime(--count));
          } else {
            ctx.dispatch(FindPasswordActionCreator.updateDownTime(120));
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

void _passwordVerify(Action action, Context<FindPasswordState> ctx) {
  String code = ctx.state.codeController.text;
  String verifyToken = ctx.state.verifyToken;
  if (code.isNotEmpty) {
    UserService.findPasswordVerify(code, verifyToken).then((data) {
      if (data['code'] == 200 && data['data']['verify_token'] != null) {
        ctx.dispatch(
            FindPasswordActionCreator.nextStep(data['data']['verify_token']));
      }
    });
  } else {
    showToast(getText(name: 'toastInputSmsCode'));
  }
}

void _passwordReset(Action action, Context<FindPasswordState> ctx) {
  String password1 = ctx.state.newPwController.text;
  String password2 = ctx.state.newPw2Controller.text;
  if (password1.isEmpty || password2.isEmpty) {
    showToast(getText(name: 'toastInputNewPassword'));
  } else if (password1 != password2) {
    showToast(getText(name: 'toastPasswordNotSame'));
  } else {
    UserService.passwordReset(password1, ctx.state.verifyToken).then((data) {
      if (data['code'] == 200) {
        showToast(getText(name: 'toastModifyPasswordSuccessful'));
        //成功跳转
        Navigator.of(ctx.context).pop();
      }
    });
  }
}

void _commitData(Action action, Context<FindPasswordState> ctx) {
  int step = ctx.state.step;
  if (step == 0) {
    //请求用户绑定信息
    ctx.dispatch(FindPasswordActionCreator.getBindInfo());
  } else if (step == 1) {
    ctx.dispatch(FindPasswordActionCreator.passwordVerify());
    //验证验证码信息
  } else if (step == 2) {
    ctx.dispatch(FindPasswordActionCreator.passwordReset());
    //修改密码
  }
}
