import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/loading_dialog/page.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountRecyclePaybackState> buildEffect() {
  return combineEffects(<Object, Effect<AccountRecyclePaybackState>>{
    AccountRecyclePaybackAction.action: _onAction,
    AccountRecyclePaybackAction.pay: _pay,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState
  });
}

void _didChangeAppLifecycleState(
    Action action, Context<AccountRecyclePaybackState> ctx) {
  print("effect__didChangeAppLifecycleState");
  var bool = ModalRoute.of(ctx.context).isCurrent;
  if (bool) {
    if (ctx.state.dealPayInfoData != null) {
      queryOrder(ctx, ctx.state.dealPayInfoData);
    }
  }
}

void _onAction(Action action, Context<AccountRecyclePaybackState> ctx) {}

void _pay(Action action, Context<AccountRecyclePaybackState> ctx) {
  UserService.recyclePay(ctx.state.recycleProOrder.data.orderId,
          ctx.state.recycleProOrder.data.payWay[ctx.state.payIndex].payWay)
      .then((data) {
    if (data.code == 200) {
      //支付宝/微信
      if (data.data.payType == 'alipay') {
        AliPayImpl().startPay(data.data.token).then((payData) {
          //查询订单
          queryOrder(ctx, data);
        });
      } else if (data.data.payType == 'wxpay') {
        //微信支付
        WxPayImpl().startPay(data.data.token).then((payInfo) {
//                  queryOrder(data.data.orderId,ctx);
//                  queryOrder(ctx, data);
        });
      } else if (data.data.payType == 'wxpayh5') {
        if (!data.data.token.startsWith("http")) {
          //走协议跳url
          launch(data.data.token);
        } else {
          AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'))
              .then((d) {
            queryOrder(ctx, data);
          });
        }
//        AppUtil.gotoH5Web(ctx.context, data.data.token, title: "支付").then((d) {
//          queryOrder(ctx, data);
//        });
      } else if (data.data.payType == 'alipayh5') {
        print("===========alipayh5============");
        AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true).then((d) {
          queryOrder(ctx, data);
        });
        print("===========alipayh5============");
      } else if (data.data.payType == 'pattern_url') {
        // url来拉起支付
        AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
            .then((d) {
          queryOrder(ctx, data);
        });
      } else if (data.data.payType == 'pattern_protocol') {
        // 协议来拉起支付
        launch(data.data.token).then((value) {
          queryOrder(ctx, data);
        });
      }
    }
  });
}

void queryOrder(
    Context<AccountRecyclePaybackState> ctx, DealPayInfoData dealOrderData) {
  //弹窗延时查询
  showDialog(
          context: ctx.context,
          builder: (context) {
            return new WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: new LoadingDialogPage().buildPage(null),
            );
          },
          barrierDismissible: false)
      .then((data) {
    Navigator.of(ctx.context).pop();
  });

  Timer.periodic(Duration(seconds: 3), (timer) {
    timer.cancel();
    UserService.recycleQueryOrder(dealOrderData.data.orderId).then((data) {
      //查询结果  提示购买成功或失败
      if (data['data']['status'] == 2) {
        //支付成功
        showToast(getText(name: 'textPaySuccessful'));
        Navigator.of(ctx.context).pop();
      } else {
        //支付失败
        showToast(getText(name: 'textPayFailed'));
        Navigator.of(ctx.context).pop();
      }
    });
  });
}
