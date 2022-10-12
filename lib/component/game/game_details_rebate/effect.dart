import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/action.dart';
import 'package:flutter_huoshu_app/page/game_details_page/action.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailsRebateState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsRebateState>>{
    GameDateilsRebateAction.action: _onAction,
    GameDateilsRebateAction.gotoRebate: _gotoRebate,
    GameDateilsRebateAction.getCoupon: _getCoupon,
  });
}

void _onAction(Action action, Context<GameDetailsRebateState> ctx) {
}
void _gotoRebate(Action action, Context<GameDetailsRebateState> ctx) {
  AppUtil.gotoPageByName(ctx.context,RebateApplyPage.pageName);
}

void _getCoupon(Action action, Context<GameDetailsRebateState> ctx) {
  int id = action.payload;
  if (null != id) {
    CouponService.obtainCoupon(id: id).then((data) {
      if (200 == data.code) {
        showToast("请到个人中心-卡券中查看");
        ctx.dispatch(GameDetailsActionCreator.getCouponList());
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      }
    });
  }
}