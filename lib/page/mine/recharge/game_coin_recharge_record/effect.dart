import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/user/cps_recharge_record.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCoinRechargeRecordState> buildEffect() {
  return combineEffects(<Object, Effect<GameCoinRechargeRecordState>>{
    GameCoinRechargeRecordAction.action: _onAction,
    GameCoinRechargeRecordAction.getRecords: _getRecords,
    GameCoinRechargeRecordAction.pop: _pop,
    GameCoinRechargeRecordAction.rechargeAgain: _rechargeAgain,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameCoinRechargeRecordState> ctx) {}
void _pop(Action action, Context<GameCoinRechargeRecordState> ctx) {
  Navigator.pop(ctx.context);
}

void _getRecords(Action action, Context<GameCoinRechargeRecordState> ctx) {
  UserService.cpsRechargeRecord(action.payload, 20).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.records, action.payload);
      println(newData);
      ctx.dispatch(GameCoinRechargeRecordActionCreator.updateRecords(newData));
    } else {}
  }).catchError((err) {});
}

void _init(Action action, Context<GameCoinRechargeRecordState> ctx) {
  ctx.dispatch(GameCoinRechargeRecordActionCreator.getRecords(1));
}

void _rechargeAgain(Action action, Context<GameCoinRechargeRecordState> ctx) {
  Navigator.pop(ctx.context);
  Record record = action.payload;
  Game game = Game(
    gameId: record.gameId,
    gameName: record.gameName,
    icon: record.gameIcon,
  );
  CpsInfo cpsInfo = CpsInfo(channelName: record.cps_name);
  game.cpsInfo = cpsInfo;
  game.rate = record.discount;
  AppUtil.gotoPageByName(ctx.context, GameCoinRechargePage.pageName,
      arguments: {"record": record, "game": game});
}
