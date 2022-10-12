import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRebateState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRebateState>>{
      GameRebateAction.action: _onAction,
      GameRebateAction.updateData: _updateData,
    },
  );
}

GameRebateState _onAction(GameRebateState state, Action action) {
  final GameRebateState newState = state.clone();
  return newState;
}

GameRebateState _updateData(GameRebateState state, Action action) {
  final GameRebateState newState = state.clone();
  newState.rebateGames = action.payload;
  return newState;
}
