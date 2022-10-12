import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/widget/dialog/ConfirmPayDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

void orderToPay({
  @required Context<Cloneable> ctx,
  @required DealPayInfoData data,
  bool needPop = false,
  Function() finishFun,
}) {
  //调用三方支付
  if (data.code == 200) {
    //支付宝/微信
    if (data.data.payType == 'alipay') {
      AliPayImpl().startPay(data.data.token).then((value) {
        //查询订单
        queryOrder(ctx, data, needPop, finishFun);
      });
    } else if (data.data.payType == 'wxpay') {
      //微信支付
      WxPayImpl().startPay(data.data.token).then((value) {
        _showPayResult(ctx, data, needPop, finishFun);
      });
    } else if (data.data.payType == 'wxpayh5') {
      if (!data.data.token.startsWith("http")) {
        //跳微信协议
        launch(data.data.token).then((value) {
          _showPayResult(ctx, data, needPop, finishFun);
        });
      } else {
        AppUtil.gotoH5Web(ctx.context, data.data.token,
                title: getText(name: 'textRecharge'), noHttpParam: true)
            .then((value) {
          queryOrder(ctx, data, needPop, finishFun);
        });
      }
    } else if (data.data.payType == 'pattern_url') {
      // url来拉起支付
      AppUtil.gotoH5Web(ctx.context, data.data.token,
              title: getText(name: 'textPay'), noHttpParam: true)
          .then((value) {
        queryOrder(ctx, data, needPop, finishFun);
      });
    } else if (data.data.payType == 'pattern_protocol') {
      // 协议来拉起支付
      launch(data.data.token).then((value) {
        _showPayResult(ctx, data, needPop, finishFun);
      });
    }
  }
}

void queryOrder(Context<Cloneable> ctx, DealPayInfoData data, bool needPop, Function() finishFun) {
  UserService.cpsQueryOrder(data.data.orderId).then((data) {
    if (data['code'] == 200 && data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));

      if (null != finishFun) {
        finishFun();
      }

      if (needPop) {
        Navigator.of(ctx.context).pop();
      }
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
    }
    ctx.broadcast(MineFragmentActionCreator.getUserInfo());
  });
}

void _showPayResult(Context<Cloneable> ctx, DealPayInfoData data, bool needPop, Function() finishFun) {
  //开始延时弹窗用户是否支付成功,延迟三秒
  Future.delayed(Duration(seconds: 2), () {
    showDialog<Null>(
        context: ctx.context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return ConfirmPayDialog(data.data.payType, (payWay) {}, () {
                //支付成功回调
                queryOrder(ctx, data, needPop, finishFun);
              });
            },
          );
        });
  });
}
