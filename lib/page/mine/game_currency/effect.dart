import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_currency_service.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_curr_bean.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCurrencyListState> buildEffect() {
  return combineEffects(<Object, Effect<GameCurrencyListState>>{
    GameCurrencyListAction.action: _onAction,
    GameCurrencyListAction.getGameCurrencyList: _getGameCurrencyList,
    Lifecycle.initState: _init
  });
}

void _getGameCurrencyList(Action action, Context<GameCurrencyListState> ctx) {
  GameCurrService.getCurrGameList(action.payload).then((data) {
    if (data.code == 200) {
      var newGames = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
      ctx.dispatch(
          GameCurrencyListActionCreator.updateGameCurrencyList(newGames));
      //取第一个游戏的精品图
    }
  }).catchError((data) {
    ctx.state.refreshHelperController.finishRefresh();
    ctx.state.refreshHelperController.finishLoad();
  });
}

void _init(Action action, Context<GameCurrencyListState> ctx) {
//  GameCurrService.getCurrGameList(1)
//      .then((data) {
//    if (data.code == 200) {
//      ctx.dispatch(GameCurrencyListActionCreator.updateGameCurrencyList(data.data.list));
//    }
//  });
  ctx.dispatch(GameCurrencyListActionCreator.getGameCurrencyList(1));
}

void _onAction(Action action, Context<GameCurrencyListState> ctx) {}
