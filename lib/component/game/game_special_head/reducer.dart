import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameSpecialHeadState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSpecialHeadState>>{
      GameSpecialHeadAction.action: _onAction,
    },
  );
}

GameSpecialHeadState _onAction(GameSpecialHeadState state, Action action) {
  final GameSpecialHeadState newState = state.clone();
  return newState;
}
