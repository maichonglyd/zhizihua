import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameComingSoonState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameComingSoonState>>{
      GameComingSoonAction.action: _onAction,
    },
  );
}

GameComingSoonState _onAction(GameComingSoonState state, Action action) {
  final GameComingSoonState newState = state.clone();
  return newState;
}
