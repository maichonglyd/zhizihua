import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameDetailsRebateState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsRebateState>>{
      GameDateilsRebateAction.action: _onAction,
    },
  );
}

GameDetailsRebateState _onAction(GameDetailsRebateState state, Action action) {
  final GameDetailsRebateState newState = state.clone();
  return newState;
}
