import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRewardSelectState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRewardSelectState>>{
      GameRewardSelectAction.action: _onAction,
    },
  );
}

GameRewardSelectState _onAction(GameRewardSelectState state, Action action) {
  final GameRewardSelectState newState = state.clone();
  return newState;
}
