import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/intergral_shop_details/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/ExchangeFailDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ExchangeRealGoodsDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ExchangeSuccessDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ExchangeTipDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<IntegralShopDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralShopDetailsState>>{
    IntegralShopDetailsAction.action: _onAction,
    IntegralShopDetailsAction.init: _initState,
    IntegralShopDetailsAction.exchangeGoods: _exchangeGoods,
    Lifecycle.initState: _initState,
  });
}

void _onAction(Action action, Context<IntegralShopDetailsState> ctx) {}

void _initState(Action action, Context<IntegralShopDetailsState> ctx) {
  UserService.getGoodsDetails(ctx.state.goods.goodsId).then((data) {
    if (data.code == 200) {
      ctx.dispatch(IntegralShopDetailsActionCreator.update(data.data));
    } else {
      ctx.dispatch(IntegralShopDetailsActionCreator.err());
    }
  }).catchError((e) {
    ctx.dispatch(IntegralShopDetailsActionCreator.err());
  });
}

void _exchangeGoods(Action action, Context<IntegralShopDetailsState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    userInfo.data.myIntegral.toInt();
    if (num.parse(ctx.state.goods.integral) > userInfo.data.myIntegral) {
      showToast(getText(name: 'toastIntegralNotEnough'));
    } else {
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return ExchangeTipDialog(ctx.state.goodsDetails.integral, () {
                  Navigator.of(context).pop();
                  if (ctx.state.goodsDetails.isReal == 2) {
                    showDialog<Null>(
                        context: ctx.context, //BuildContext对象
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, state) {
                              return ExchangeRealGoodsDialog(
                                  ctx.state.goods.goodsId);
                            },
                          );
                        });
                  } else {
                    UserService.exchangeGoods(ctx.state.goods.goodsId)
                        .then((data) {
                      if (data['code'] == 200) {
                        showDialog<Null>(
                            context: ctx.context, //BuildContext对象
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, state) {
                                  return ExchangeSuccessDialog();
                                },
                              );
                            });
                        //刷新数据用户中心数据
                        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
                      } else if (data['code'] == 44001) {
                        showDialog<Null>(
                            context: ctx.context, //BuildContext对象
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, state) {
                                  return ExchangeFailDialog();
                                },
                              );
                            });
                        //刷新数据
                      }
                    });
                  }
                });
              },
            );
          });
    }
  });
}
