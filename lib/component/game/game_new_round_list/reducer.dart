import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameNewRoundListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameNewRoundListState>>{
      GameNewRoundListAction.action: _onAction,
      GameNewRoundListAction.updateData: _updateData,
    },
  );
}

GameNewRoundListState _onAction(GameNewRoundListState state, Action action) {
  final GameNewRoundListState newState = state.clone();
  return newState;
}

GameNewRoundListState _updateData(GameNewRoundListState state, Action action) {
  final GameNewRoundListState newState = state.clone();
  newState.gameList = action.payload;
  return newState;
}
