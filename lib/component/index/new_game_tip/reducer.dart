import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewGameTipState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewGameTipState>>{
      NewGameTipAction.action: _onAction,
    },
  );
}

NewGameTipState _onAction(NewGameTipState state, Action action) {
  final NewGameTipState newState = state.clone();
  return newState;
}
