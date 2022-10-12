import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSpecialPageState> buildEffect() {
  return combineEffects(<Object, Effect<GameSpecialPageState>>{
    GameSpecialPageAction.action: _onAction,
    Lifecycle.initState: _init,
    GameSpecialPageAction.getSpecialListGame: _getSpecialListGame,
  });
}

void _onAction(Action action, Context<GameSpecialPageState> ctx) {}

void _getSpecialListGame(Action action, Context<GameSpecialPageState> ctx) {
  GameService.getSpecialListGame(ctx.state.specialId, action.payload, 10)
      .then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
      ctx.dispatch(GameSpecialPageActionCreator.updateList(newData));

      if (null != data.data.topicData) {
        ctx.dispatch(GameSpecialPageActionCreator.updateTopicData(data.data.topicData));
      }
    }
  });
}

void _init(Action action, Context<GameSpecialPageState> ctx) {
  ctx.dispatch(GameSpecialPageActionCreator.getSpecialListGame(1));
}
