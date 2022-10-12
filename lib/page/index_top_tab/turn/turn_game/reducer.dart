import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TurnGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<TurnGameState>>{
      TurnGameAction.action: _onAction,
      TurnGameAction.updateData: _updateData,
    },
  );
}

TurnGameState _onAction(TurnGameState state, Action action) {
  final TurnGameState newState = state.clone();
  return newState;
}

TurnGameState _updateData(TurnGameState state, Action action) {
  final TurnGameState newState = state.clone();
  newState.list = action.payload;
  return newState;
}
