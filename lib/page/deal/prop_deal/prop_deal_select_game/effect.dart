import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealSelectGameState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealSelectGameState>>{
    PropDealSelectGameAction.action: _onAction,
    PropDealSelectGameAction.getGames: _getGames,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PropDealSelectGameState> ctx) {}

void _init(Action action, Context<PropDealSelectGameState> ctx) {
  ctx.dispatch(PropDealSelectGameActionCreator.getGames(1));
}

void _getGames(Action action, Context<PropDealSelectGameState> ctx) {
  DealService.getMaterialGameListByMine(action.payload).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
      ctx.dispatch(PropDealSelectGameActionCreator.updateGames(newData));
    }
  });
}
