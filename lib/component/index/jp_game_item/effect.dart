import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<JPGameItemState> buildEffect() {
  return combineEffects(<Object, Effect<JPGameItemState>>{
    JPGameItemAction.action: _onAction,
    JPGameItemAction.gotoDetails: _gotoDetails,
  });
}

void _onAction(Action action, Context<JPGameItemState> ctx) {}

void _gotoDetails(Action action, Context<JPGameItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: action.payload);
}
