import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexRowGameState> buildEffect() {
  return combineEffects(<Object, Effect<IndexRowGameState>>{
    IndexRowGameAction.action: _onAction,
    IndexRowGameAction.gotoGameDetails: _gotoGameDetails,
  });
}

void _onAction(Action action, Context<IndexRowGameState> ctx) {}

void _gotoGameDetails(Action action, Context<IndexRowGameState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: action.payload);
}
