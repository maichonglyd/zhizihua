import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_order_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_edit_page/action.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_shop_list_page/action.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_buy_list_page/page.dart';
import 'package:flutter_huoshu_app/page/game/game_pic_gallery/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/utils/CheckAppAvailability.dart';
import 'package:flutter_huoshu_app/widget/dialog/BuyAgreementDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ConfirmPayDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/DealPayDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<DealDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<DealDetailsState>>{
    DealDetailsAction.gotoGallery: _gotoGallery,
    Lifecycle.initState: _init,
    DealDetailsAction.showBuyAgreementDialog: _showBuyAgreementDialog,
    DealDetailsAction.gotoGame: _gotoGame,
    DealSellEditAction.onEditOK: _onEditOK,
    IndexDealFragmentAction.onCancelOK: _onCancelOK,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState,
    Lifecycle.deactivate: _deactivate,
    Lifecycle.reassemble: _reassemble,
    Lifecycle.didUpdateWidget: _didUpdateWidget,
    AppLifecycleState.paused: _paused,
    AppLifecycleState.resumed: _resumed,
    AppLifecycleState.detached: _detached,
    AppLifecycleState.inactive: _inactive,
  });
}

void _gotoGallery(Action action, Context<DealDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GalleryPage.pageName, arguments: {
    'urls': ctx.state.dealGoods.image.map((image) => image).toList(),
    "initIndex": action.payload
  });
}

void _detached(Action action, Context<DealDetailsState> ctx) {
  print("_detached--------------");
}

void _inactive(Action action, Context<DealDetailsState> ctx) {
  print("_inactive--------------");
}

void _resumed(Action action, Context<DealDetailsState> ctx) {
  print("_resumed--------------");
}

void _paused(Action action, Context<DealDetailsState> ctx) {
  print("_paused--------------");
}

//不可见的时候,刷新一下
void _deactivate(Action action, Context<DealDetailsState> ctx) {
  ctx.broadcast(DealShopListPageActionCreator.onGetData(1));
  ctx.broadcast(IndexDealFragmentActionCreator.getDealGoods(1));
  print("_deactivate--------------");
}

void _reassemble(Action action, Context<DealDetailsState> ctx) {
//  showToast("_reassemble");
  print("_reassemble--------------");
}

void _didUpdateWidget(Action action, Context<DealDetailsState> ctx) {
  print("_didUpdateWidget--------------");
}

void _gotoGame(Action action, Context<DealDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": ctx.state.dealGoods.gameId});
}

void _showBuyAgreementDialog(Action action, Context<DealDetailsState> ctx) {
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return BuyAgreementDialog(() {
              print("ok");
              Navigator.of(context).pop();
              // 下单  弹出支付界面
              DealService.dealCreateOrder(ctx, ctx.state.dealGoods.goodsId)
                  .then((data) {
                //请求支付方式
                if (data.code == 200) {
                  showPay(ctx, data);
                }
              });
            });
          },
        );
      });
}

//查单
void _didChangeAppLifecycleState(Action action, Context<DealDetailsState> ctx) {
  var bool = ModalRoute.of(ctx.context).isCurrent;
  print("_didChangeAppLifecycleState--------------");
//  showToast("_didChangeAppLifecycleState");
  if (bool) {
    if (ctx.state.dealPayInfoData != null) {
      queryOrder(ctx, ctx.state.dealPayInfoData);
    }
    //关闭当前页面
    Navigator.of(ctx.context).pop();
    //通知列表刷新,商品列表刷新
    ctx.broadcast(DealShopListPageActionCreator.onGetData(1));
    ctx.broadcast(IndexDealFragmentActionCreator.getDealGoods(1));
  }
}

void showPay(Context<DealDetailsState> ctx, DealOrderData dealOrderData) {
  //显示界面
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DealPayDialog(ctx.state.dealGoods, (payWay) {
          //请求支付信息
          DealService.pay(dealOrderData.data.orderId, payWay,
                  dealOrderData.data.payToken)
              .then((data) {
            //调起三方支付
            if (data.code == 200) {
              //支付宝/微信
              if (data.data.payType == 'alipay') {
                AliPayImpl().startPay(data.data.token).then((payData) {
                  print("===========alipay============");
                  print(payData);
                  //查询订单
                  queryOrder(ctx, data);
                  print("===========alipay============");
                });
              } else if (data.data.payType == 'wxpay') {
                //微信支付
                var wxinfo = json.decode(data.data.token);
                WxPayImpl().startPay(data.data.token).then((payInfo) {
//                  queryOrder(data.data.orderId,ctx);
//                  queryOrder(ctx, data);
                });
              } else if (data.data.payType == 'wxpayh5') {
                if (!data.data.token.startsWith("http")) {
                  //跳微信协议
                  CheckAppAvailability.checkAvailability(AppPlatform.WeChat, () {
                    launch(data.data.token).then((value) {
                      //页面返回的时候
                      _showPayResult(ctx, 'wxpayh5', data);
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
                  _showPayResult(ctx, data.data.payType, data);
                });
              }
            }
          });
        });
      });
}

void queryOrder(Context<DealDetailsState> ctx, DealPayInfoData dealOrderData) {
  DealService.queryOrder(dealOrderData.data.orderId).then((data) {
    //查询结果  提示购买成功或失败
    if (data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));
      //通知列表刷新,商品列表刷新
      ctx.broadcast(DealShopListPageActionCreator.onGetData(1));
      ctx.broadcast(IndexDealFragmentActionCreator.getDealGoods(1));
      AppUtil.gotoPageByName(ctx.context, MyBuyListPage.pageName, arguments: null).then((data) {
        Navigator.of(ctx.context).pop();
      });
    } else if (data['data']['status'] == 1) {
      showToast(getText(name: 'textPayCancel'));
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
    }
  });
}

void _showPayResult(Context<DealDetailsState> ctx, String payWay, DealPayInfoData dealOrderData) {
  //开始延时弹窗用户是否支付成功,延迟三秒
  Future.delayed(Duration(seconds: 2), () {
    showDialog<Null>(
        context: ctx.context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return ConfirmPayDialog(payWay, (payWay) {
                ctx.dispatch(DealDetailsActionCreator.showBuyAgreementDialog());
              }, () {
                //支付成功回调
                queryOrder(ctx, dealOrderData);
              });
            },
          );
        });
  });
}

void _init(Action action, Context<DealDetailsState> ctx) {
  _updateData(action, ctx);
}

void _updateData(Action action, Context<DealDetailsState> ctx) {
  DealService.getDealDetails(ctx.state.goodsId).then((data) {
    if (data.code == 200) {
      ctx.dispatch(DealDetailsActionCreator.updateDetails(data.data));
    }
  });
}

void _onEditOK(Action action, Context<DealDetailsState> ctx) {
  _updateData(action, ctx);
}

void _onCancelOK(Action action, Context<DealDetailsState> ctx) {
  _updateData(action, ctx);
}
