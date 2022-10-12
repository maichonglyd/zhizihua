import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCardState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCardState>>{
      GameCardAction.action: _onAction,
    },
  );
}

GameCardState _onAction(GameCardState state, Action action) {
  final GameCardState newState = state.clone();
  return newState;
}
