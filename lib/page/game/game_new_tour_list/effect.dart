import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/game/game_new_round_list/action.dart';
import 'action.dart';
import 'state.dart';

Effect<GameNewTourListState> buildEffect() {
  return combineEffects(<Object, Effect<GameNewTourListState>>{
    Lifecycle.initState: _init,
    GameNewTourListAction.action: _onAction,
    GameNewTourListAction.updateData: _updateData,
  });
}

void _onAction(Action action, Context<GameNewTourListState> ctx) {
}

void _init(Action action, Context<GameNewTourListState> ctx) {
}

void _updateData(Action action, Context<GameNewTourListState> ctx) {
  ctx.dispatch(GameNewRoundListActionCreator.onAction());
}

