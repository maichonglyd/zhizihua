import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/turn_game_service.dart';

import 'action.dart';
import 'state.dart';

Effect<TurnGameDetailState> buildEffect() {
  return combineEffects(<Object, Effect<TurnGameDetailState>>{
    Lifecycle.initState: _init,
    TurnGameDetailAction.action: _onAction,
    TurnGameDetailAction.getData: _getData,
    TurnGameDetailAction.getStopGame: _getStopGame,
  });
}

void _onAction(Action action, Context<TurnGameDetailState> ctx) {
}

void _init(Action action, Context<TurnGameDetailState> ctx) {
  ctx.dispatch(TurnGameDetailActionCreator.getData());
}

void _getData(Action action, Context<TurnGameDetailState> ctx) {
  TurnGameService.getTurnGameDetail(ctx.state.activityId).then((data) {
    if (200 == data.code) {
      ctx.dispatch(TurnGameDetailActionCreator.updateData(data));
    }
  });
  ctx.dispatch(TurnGameDetailActionCreator.getStopGame());
}

void _getStopGame(Action action, Context<TurnGameDetailState> ctx) {
  TurnGameService.getTurnGameStopList(1).then((data) {
    if (200 == data.code) {
      ctx.dispatch(TurnGameDetailActionCreator.updateBottomButton(null != data.data && null != data.data.list && data.data.list.length > 0));
    }
  });
}