import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StopGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<StopGameState>>{
      StopGameAction.action: _onAction,
      StopGameAction.updateData: _updateData,
    },
  );
}

StopGameState _onAction(StopGameState state, Action action) {
  final StopGameState newState = state.clone();
  return newState;
}

StopGameState _updateData(StopGameState state, Action action) {
  final StopGameState newState = state.clone();
  newState.list = action.payload;
  return newState;
}
