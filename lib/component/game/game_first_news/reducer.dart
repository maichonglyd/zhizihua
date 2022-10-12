import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameFirstNewsState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameFirstNewsState>>{
      GameFirstNewsAction.action: _onAction,
    },
  );
}

GameFirstNewsState _onAction(GameFirstNewsState state, Action action) {
  final GameFirstNewsState newState = state.clone();
  return newState;
}
