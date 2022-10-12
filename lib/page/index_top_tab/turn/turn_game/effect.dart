import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/turn_game_service.dart';

import 'action.dart';
import 'state.dart';

Effect<TurnGameState> buildEffect() {
  return combineEffects(<Object, Effect<TurnGameState>>{
    Lifecycle.initState: _init,
    TurnGameAction.action: _onAction,
    TurnGameAction.getData: _getData,
  });
}

void _onAction(Action action, Context<TurnGameState> ctx) {}

void _init(Action action, Context<TurnGameState> ctx) {
  ctx.dispatch(TurnGameActionCreator.getData(1));
}

void _getData(Action action, Context<TurnGameState> ctx) {
  int page = action.payload;
  TurnGameService.getTurnGameList(page).then((data) {
    if (200 == data.code) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.list, page);
      ctx.dispatch(TurnGameActionCreator.updateData(newData));
    }
  });
}
