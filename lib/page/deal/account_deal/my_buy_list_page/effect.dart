import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_my_order_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_order_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_details_page/page.dart';
import 'package:flutter_huoshu_app/utils/CheckAppAvailability.dart';
import 'package:flutter_huoshu_app/widget/dialog/ConfirmPayDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/DealPayDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<MyBuyListState> buildEffect() {
  return combineEffects(<Object, Effect<MyBuyListState>>{
    MyBuyListAction.action: _onAction,
    Lifecycle.initState: _init,
    MyBuyListAction.onGetData: _onGetData,
    MyBuyListAction.onGotoDealDetails: _onGotoDealDetails,
    MyBuyListAction.pay: _pay,
  });
}

void _onAction(Action action, Context<MyBuyListState> ctx) {}

void _pay(Action action, Context<MyBuyListState> ctx) {
  int index = action.payload;

  DealService.dealCreateOrder(ctx, ctx.state.orders[index].goodsId)
      .then((data) {
    //请求支付方式
    if (data.code == 200) {
      showPay(ctx, data, index);
    }
  });
}

void showPay(
    Context<MyBuyListState> ctx, DealOrderData dealOrderData, int index) {
  //显示界面
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        Order order = ctx.state.orders[index];
        DealGoods dealGoods = DealGoods(
            gameName: order.gameName,
            serverName: order.serverName,
            mgMemId: order.mgMemId,
            price: order.price.toString());

        return DealPayDialog(dealGoods, (payWay) {
          //请求支付信息
          DealService.pay(dealOrderData.data.orderId, payWay,
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
                  queryOrder(ctx, data);
                });
              } else if (data.data.payType == 'wxpayh5') {
                if (!data.data.token.startsWith("http")) {
                  //跳微信协议
                  CheckAppAvailability.checkAvailability(AppPlatform.WeChat, () {
                    launch(data.data.token).then((value) {
                      //页面返回的时候
                      _showPayResult(ctx, 'wxpayh5', data, index);
                    });
                  });
                } else {
                  AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
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
                  _showPayResult(ctx, 'pattern_protocol', data, index);
                });
              }
            }
          });
        });
      });
}

void queryOrder(Context<MyBuyListState> ctx, DealPayInfoData dealOrderData) {
  DealService.queryOrder(dealOrderData.data.orderId).then((data) {
    //查询结果  提示购买成功或失败
    if (data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));
      //刷新界面
      ctx.dispatch(MyBuyListActionCreator.onGetData(1));
    } else if (data['data']['status'] == 1) {
      showToast(getText(name: 'textPayCancel'));
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
    }
  });
}

void _showPayResult(Context<MyBuyListState> ctx, String payWay, DealPayInfoData dealOrderData, int index) {
  //开始延时弹窗用户是否支付成功,延迟三秒
  Future.delayed(Duration(seconds: 2), () {
    showDialog<Null>(
        context: ctx.context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return ConfirmPayDialog(payWay, (payWay) {
                ctx.dispatch(MyBuyListActionCreator.pay(index));
              }, () {
                //支付成功回调
                queryOrder(ctx, dealOrderData);
              });
            },
          );
        });
  });
}

void _init(Action action, Context<MyBuyListState> ctx) {
  ctx.dispatch(MyBuyListActionCreator.onGetData(1));
}

void _onGetData(Action action, Context<MyBuyListState> ctx) {
  DealService.getAccountOrderList(action.payload, 20).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.orders, action.payload);
      ctx.dispatch(MyBuyListActionCreator.update(newData));
    }
  });
}

void _onGotoDealDetails(Action action, Context<MyBuyListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealDetailsPage.pageName,
      arguments: action.payload);
}
