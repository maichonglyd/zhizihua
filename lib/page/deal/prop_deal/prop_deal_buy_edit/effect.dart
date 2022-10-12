import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_order_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/utils/CheckAppAvailability.dart';
import 'package:flutter_huoshu_app/widget/dialog/ConfirmPayDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/DealPayDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/DealPropPayDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealBuyState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealBuyState>>{
    PropDealBuyAction.action: _onAction,
    PropDealBuyAction.buy: buy,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState,
    Lifecycle.deactivate: _deactivate,
    Lifecycle.reassemble: _reassemble,
    Lifecycle.didUpdateWidget: _didUpdateWidget
  });
}

void _deactivate(Action action, Context<PropDealBuyState> ctx) {
  print("_deactivate--------------");
  ctx.broadcast(PropDealFragmentActionCreator.getIndexData());
}

void _reassemble(Action action, Context<PropDealBuyState> ctx) {
  print("_reassemble--------------");
}

void _didUpdateWidget(Action action, Context<PropDealBuyState> ctx) {
  print("_didUpdateWidget--------------");
}

//查单
void _didChangeAppLifecycleState(Action action, Context<PropDealBuyState> ctx) {
  var bool = ModalRoute.of(ctx.context).isCurrent;
  print("_didChangeAppLifecycleState--------------");
//  if (bool) {
//    if (ctx.state.dealPayInfoData != null) {
//      queryOrder(ctx, ctx.state.dealPayInfoData);
//    }
//    //关闭当前页面
//    Navigator.of(ctx.context).pop();
//    //通知列表刷新,商品列表刷新
//    ctx.broadcast(DealShopListPageActionCreator.onGetData(1));
//    ctx.broadcast(IndexDealFragmentActionCreator.getDealGoods(1));
//
//  }
}

void _onAction(Action action, Context<PropDealBuyState> ctx) {}

void buy(Action action, Context<PropDealBuyState> ctx) {
  String serverName = ctx.state.textEditingControllers[0].text;
  if (serverName == null || serverName.isEmpty) {
    showToast(getText(name: 'toastServiceNotNull'));
    return;
  }
  String roleName = ctx.state.textEditingControllers[1].text;
  if (roleName == null || roleName.isEmpty) {
    showToast(getText(name: 'toastRoleNotNull'));
    return;
  }

  String mobile = ctx.state.textEditingControllers[2].text;
  if (mobile == null || mobile.isEmpty) {
    showToast(getText(name: 'toastPhoneNotNull'));
    return;
  }

  String username = ctx.state.textEditingControllers[3].text;
  if (username == null || username.isEmpty) {
    showToast(getText(name: 'toastUsernameNotNull'));
    return;
  }

  String password = ctx.state.textEditingControllers[4].text;
  if (password == null || password.isEmpty) {
    showToast(getText(name: 'toastPasswordNotNull'));
    return;
  }

  String content = ctx.state.textEditingControllers[5].text;
  if (content == null || content.isEmpty) {
    showToast(getText(name: 'toastRemarkNotNull'));
    return;
  }
  //下单
  DealService.addMaterialOrder(ctx.state.goods.goodsId,
          userName: username,
          passWord: password,
          roleName: roleName,
          serverName: serverName,
          mobile: mobile,
          remark: content)
      .then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      showPay(ctx, roleName, serverName, data);
    } else if (CommonDio.GOODS_NOT_EXIST == data.code) {
      Navigator.of(ctx.context).pop({'status':2});
    }
  });
}

void showPay(Context<PropDealBuyState> ctx, String roleName, String serverName,
    DealOrderData dealOrderData) {
  //显示界面
  //显示界面
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DealPropPayDialog(ctx.state.goods, roleName, serverName,
            (payWay) {
          //请求支付信息
          DealService.materialPay(dealOrderData.data.orderId, payWay,
                  dealOrderData.data.payToken)
              .then((data) {
            //调起三方支付
            if (data.code == 200) {
              //支付宝/微信
              if (data.data.payType == 'alipay') {
                AliPayImpl().startPay(data.data.token).then((payData) {
                  print(payData);
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
                  CheckAppAvailability.checkAvailability(AppPlatform.WeChat, () {
                    launch(data.data.token).then((value) {
                      _showPayResult(ctx, 'wxpayh5', data);
                    });
                  });
                } else {
                  AppUtil.gotoH5Web(ctx.context, data.data.token, title:getText(name: 'textPay'), noHttpParam: true)
                      .then((d) {
                    queryOrder(ctx, data);
                  });
                }
              } else if (data.data.payType == 'pattern_url') {
                // url来拉起支付
                AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
                    .then((d) {
                  queryOrder(ctx, data);
                });
              } else if (data.data.payType == 'pattern_protocol') {
                // 协议来拉起支付
                launch(data.data.token).then((value) {
                  _showPayResult(ctx, data.data.payType, data);
                });
              }
            }
          });
        });
      });
}

void queryOrder(Context<PropDealBuyState> ctx, DealPayInfoData dealOrderData) {
  DealService.materialQueryOrder(dealOrderData.data.orderId).then((data) {
    //查询结果  提示购买成功或失败
    if (data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));
      //通知道具商城页面刷新
      ctx.broadcast(PropDealFragmentActionCreator.getIndexData());
      Navigator.of(ctx.context).pop({'status':2});
    } else if (data['data']['status'] == 1) {
      showToast(getText(name: 'textPayCancel'));
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
    }
  });
}

void _showPayResult(Context<PropDealBuyState> ctx, String payWay, DealPayInfoData dealOrderData) {
  //开始延时弹窗用户是否支付成功,延迟两秒
  Future.delayed(Duration(seconds: 2), () {
    showDialog<Null>(
        context: ctx.context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return ConfirmPayDialog(payWay, (payWay) {
                ctx.dispatch(PropDealBuyActionCreator.buy());
              }, () {
                //支付成功回调
                queryOrder(ctx, dealOrderData);
              });
            },
          );
        });
  });
}