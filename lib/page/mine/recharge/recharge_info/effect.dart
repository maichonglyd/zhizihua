import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge/page.dart';
import 'action.dart';
import 'state.dart';

Effect<RechargeInfoState> buildEffect() {
  return combineEffects(<Object, Effect<RechargeInfoState>>{
    RechargeInfoAction.action: _onAction,
    RechargeInfoAction.gotoRechargeInfo: _gotoRechargeInfo,
  });
}

void _onAction(Action action, Context<RechargeInfoState> ctx) {}

void _gotoRechargeInfo(Action action, Context<RechargeInfoState> ctx) {
  Navigator.pop(ctx.context);
  AppUtil.gotoPageByName(ctx.context, GameCoinRechargePage.pageName,
      arguments: {"game": ctx.state.game, "game_id": ctx.state.gameId});
}
