import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSpecialHeadState> buildEffect() {
  return combineEffects(<Object, Effect<GameSpecialHeadState>>{
    GameSpecialHeadAction.action: _onAction,
    GameSpecialHeadAction.gotoSpecialList: _gotoSpecialList,
    GameSpecialHeadAction.gotoGameDetails: _gotoGameDetails,
  });
}

void _onAction(Action action, Context<GameSpecialHeadState> ctx) {}
void _gotoGameDetails(Action action, Context<GameSpecialHeadState> ctx) {
//  AppUtil.gotoPageByName(ctx.context,GameDetailsPage.pageName,arguments: action.payload);
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": action.payload});
}

void _gotoSpecialList(Action action, Context<GameSpecialHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameSpecialPagePage.pageName, arguments: {
    "title": ctx.state.gameSpecial.topicName,
    "specialId": ctx.state.gameSpecial.topicId
  });
}
