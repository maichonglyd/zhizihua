import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRankState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRankState>>{
      GameRankAction.action: _onAction,
    },
  );
}

GameRankState _onAction(GameRankState state, Action action) {
  final GameRankState newState = state.clone();
  return newState;
}
