import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/integral_shop_fragment/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/action.dart';
import 'package:flutter_huoshu_app/page/mine/intergral_shop_details/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<IntegralShopItemState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralShopItemState>>{
    IntegralShopItemAction.action: _onAction,
    IntegralShopItemAction.exchangeGoods: _exchangeGoods,
    IntegralShopItemAction.gotoShopDetails: _gotoShopDetails,
  });
}

void _onAction(Action action, Context<IntegralShopItemState> ctx) {}

void _gotoShopDetails(Action action, Context<IntegralShopItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, IntegralShopDetailsPage.namePage,
      arguments: {
        "goods": ctx.state.goods,
      }).then((data) {
    //刷新数据
    ctx.dispatch(IntegralShopFragmentActionCreator.getIntegralGoods(1));
    ctx.broadcast(IntegralShopActionCreator.onUpdateIntegral());
  });
}

void _exchangeGoods(Action action, Context<IntegralShopItemState> ctx) {
  UserService.exchangeGoods(ctx.state.goods.goodsId).then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastExchangeSuccessful'));
      UserService.getUserInfo().then((UserInfo userInfo) {
        ctx.dispatch(MineFragmentActionCreator.updateUserInfo(userInfo));
        ctx.broadcast(IntegralShopActionCreator.onUpdateIntegral());
      });
    }
  });
}
