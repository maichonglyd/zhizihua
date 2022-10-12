import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameSpecialHeadState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSpecialHeadState>>{
      AtHomeRequiredAction.action: _onAction,
    },
  );
}

GameSpecialHeadState _onAction(GameSpecialHeadState state, Action action) {
  final GameSpecialHeadState newState = state.clone();
  return newState;
}
