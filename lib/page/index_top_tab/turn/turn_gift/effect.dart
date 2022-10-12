import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/turn_game_service.dart';

import 'action.dart';
import 'state.dart';

Effect<TurnGiftState> buildEffect() {
  return combineEffects(<Object, Effect<TurnGiftState>>{
    Lifecycle.initState: _init,
    TurnGiftAction.action: _onAction,
    TurnGiftAction.getData: _getData,
  });
}

void _onAction(Action action, Context<TurnGiftState> ctx) {}

void _init(Action action, Context<TurnGiftState> ctx) {
  ctx.dispatch(TurnGiftActionCreator.getData(1));
}

void _getData(Action action, Context<TurnGiftState> ctx) {
  int page = action.payload;
  TurnGameService.getTurnGameApplyList(page).then((data) {
    if (200 == data.code) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.list, page);
      ctx.dispatch(TurnGiftActionCreator.updateData(newData));
    }
  });
}
