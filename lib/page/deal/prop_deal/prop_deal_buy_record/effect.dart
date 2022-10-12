import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_order_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_list.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_order_details/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/ConfirmPayDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/DealPropPayDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealBuyRecordState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealBuyRecordState>>{
    PropDealBuyRecordAction.action: _onAction,
    PropDealBuyRecordAction.getOrders: _getOrders,
    PropDealBuyRecordAction.gotoDetails: _gotoDetails,
    PropDealBuyRecordAction.buy: _buy,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PropDealBuyRecordState> ctx) {}

void _gotoDetails(Action action, Context<PropDealBuyRecordState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealOrderDetailsPage.pageName,
      arguments: {"orderId": action.payload});
}

void _buy(Action action, Context<PropDealBuyRecordState> ctx) {
  Order order = action.payload;
  DealService.rePay(order.orderId).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      showPay(ctx, order.roleName, order.serverName, data, order.title,
          order.payTime, order.price);
    }
  });
}

void _init(Action action, Context<PropDealBuyRecordState> ctx) {
  ctx.dispatch(PropDealBuyRecordActionCreator.getOrders(1));
}

void _getOrders(Action action, Context<PropDealBuyRecordState> ctx) {
  DealService.getMaterialOrders(action.payload, 1).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.orders, action.payload);
      ctx.dispatch(PropDealBuyRecordActionCreator.updateOrders(newData));
    }
  });
}

void showPay(
    Context<PropDealBuyRecordState> ctx,
    String roleName,
    String serverName,
    DealOrderData dealOrderData,
    String title,
    int createTime,
    String price) {
  //显示界面
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DealPropPayDialog(
            Goods(title: title, createTime: createTime, price: price),
            roleName,
            serverName, (payWay) {
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
                AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
                    .then((d) {
                  queryOrder(ctx, data);
                });
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

void queryOrder(
    Context<PropDealBuyRecordState> ctx, DealPayInfoData dealOrderData) {
  DealService.materialQueryOrder(dealOrderData.data.orderId).then((data) {
    //查询结果  提示购买成功或失败
    if (data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));
      Navigator.of(ctx.context).pop();
    } else if (data['data']['status'] == 1) {
      showToast(getText(name: 'textPayCancel'));
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
    }
  });
}

void _showPayResult(Context<PropDealBuyRecordState> ctx, String payWay, DealPayInfoData dealOrderData) {
  //开始延时弹窗用户是否支付成功,延迟三秒
  Future.delayed(Duration(seconds: 2), () {
    showDialog<Null>(
        context: ctx.context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return ConfirmPayDialog(payWay, (payWay) {
              }, () {
                //支付成功回调
                queryOrder(ctx, dealOrderData);
              });
            },
          );
        });
  });
}
