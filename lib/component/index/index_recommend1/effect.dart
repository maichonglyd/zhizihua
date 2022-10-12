import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSpecialHeadState> buildEffect() {
  return combineEffects(<Object, Effect<GameSpecialHeadState>>{
    IndexRecommendAction.action: _onAction,
    IndexRecommendAction.gotoGameDetails: _gotoGameDetails,
  });
}

void _onAction(Action action, Context<GameSpecialHeadState> ctx) {}

void _gotoGameDetails(Action action, Context<GameSpecialHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": action.payload});
}
