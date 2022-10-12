import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameSimpleHeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSimpleHeaderState>>{
      GameSimpleHeaderAction.action: _onAction,
    },
  );
}

GameSimpleHeaderState _onAction(GameSimpleHeaderState state, Action action) {
  final GameSimpleHeaderState newState = state.clone();
  return newState;
}
