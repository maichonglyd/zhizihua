import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameHotThisWeekendState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameHotThisWeekendState>>{
      GameHotThisWeekendAction.action: _onAction,
    },
  );
}

GameHotThisWeekendState _onAction(GameHotThisWeekendState state, Action action) {
  final GameHotThisWeekendState newState = state.clone();
  return newState;
}
