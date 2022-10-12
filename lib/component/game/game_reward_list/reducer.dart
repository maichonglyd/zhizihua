import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRewardListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRewardListState>>{
      GameRewardListAction.action: _onAction,
    },
  );
}

GameRewardListState _onAction(GameRewardListState state, Action action) {
  final GameRewardListState newState = state.clone();
  return newState;
}
