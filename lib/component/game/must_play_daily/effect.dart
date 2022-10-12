import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSpecialHeadState> buildEffect() {
  return combineEffects(<Object, Effect<GameSpecialHeadState>>{
    MustPlayDailyAction.action: _onAction,
    MustPlayDailyAction.gotoDetails: _gotoDetails,
    MustPlayDailyAction.gotoSpecialList: _gotoSpecialList,
  });
}

void _onAction(Action action, Context<GameSpecialHeadState> ctx) {}

void _gotoDetails(Action action, Context<GameSpecialHeadState> ctx) {
//  AppUtil.gotoGameDetailOrH5Game(ctx.context,action.payload);
  AppUtil.gotoGameDetail(ctx.context, action.payload);
}

void _gotoSpecialList(Action action, Context<GameSpecialHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameSpecialPagePage.pageName, arguments: {
    "title": ctx.state.gameSpecial.topicName,
    "specialId": ctx.state.gameSpecial.topicId
  });
}
