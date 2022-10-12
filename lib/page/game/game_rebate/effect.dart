import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/rebate_service.dart';

import 'action.dart';
import 'state.dart';

Effect<GameRebateState> buildEffect() {
  return combineEffects(<Object, Effect<GameRebateState>>{
    Lifecycle.initState: _init,
    GameRebateAction.action: _onAction,
    GameRebateAction.getData: _getData,
    GameRebateAction.applyRebate: _applyRebate,
  });
}

void _onAction(Action action, Context<GameRebateState> ctx) {}

void _init(Action action, Context<GameRebateState> ctx) {
  ctx.dispatch(GameRebateActionCreator.getData(1));
}

void _getData(Action action, Context<GameRebateState> ctx) {
  int page = action.payload;
  GameService.getNewListByGameId(ctx.state.gameId, 2, page, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.rebateGames, page);
      ctx.dispatch(GameRebateActionCreator.updateData(newData));
    }
  });
}

void _applyRebate(Action action, Context<GameRebateState> ctx) {

}
