import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/action.dart';
import 'action.dart';
import 'state.dart';

Effect<GameClassifyState> buildEffect() {
  return combineEffects(<Object, Effect<GameClassifyState>>{
    GameClassifyAction.action: _onAction,
    GameClassifyAction.selectIndex: _selectIndex,
    GameClassifyAction.selectTypeIndex: _selectTypeIndex,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameClassifyState> ctx) {}

void _selectIndex(Action action, Context<GameClassifyState> ctx) {
  ctx.dispatch(GameClassifyActionCreator.updateIndex(action.payload));
  ctx.dispatch(GameListActionCreator.selectClassify(
      ctx.state.index,
      ctx.state.typeIndex == 0
          ? 0
          : ctx.state.gameType.list[ctx.state.typeIndex - 1].id));
}

void _selectTypeIndex(Action action, Context<GameClassifyState> ctx) {
  ctx.dispatch(GameClassifyActionCreator.updateTypeIndex(action.payload));
  ctx.dispatch(GameListActionCreator.selectClassify(
      ctx.state.index,
      ctx.state.typeIndex == 0
          ? 0
          : ctx.state.gameType.list[ctx.state.typeIndex - 1].id));
}

void _init(Action action, Context<GameClassifyState> ctx) {
  GameService.getGameType().then((data) {
    ctx.dispatch(GameClassifyActionCreator.updateGameType(data.data));
//    ctx.dispatch(GameListActionCreator.getGameList({}));
  });
}
