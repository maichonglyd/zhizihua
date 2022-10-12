import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameFirstRoundState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameFirstRoundState>>{
      GameFirstRoundAction.action: _onAction,
    },
  );
}

GameFirstRoundState _onAction(GameFirstRoundState state, Action action) {
  final GameFirstRoundState newState = state.clone();
  return newState;
}
