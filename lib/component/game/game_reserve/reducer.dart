import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameReserveState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameReserveState>>{
      GameReserveAction.action: _onAction,
      GameReserveAction.updateData: _updateData,
    },
  );
}

GameReserveState _onAction(GameReserveState state, Action action) {
  final GameReserveState newState = state.clone();
  return newState;
}

GameReserveState _updateData(GameReserveState state, Action action) {
  final GameReserveState newState = state.clone();
  newState.games = action.payload;
  return newState;
}
