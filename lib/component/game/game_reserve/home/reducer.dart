import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewGameReserveState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewGameReserveState>>{
      NewGameReserveAction.action: _onAction,
    },
  );
}

NewGameReserveState _onAction(NewGameReserveState state, Action action) {
  final NewGameReserveState newState = state.clone();
  return newState;
}
