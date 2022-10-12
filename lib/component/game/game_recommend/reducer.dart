import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRecommendState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRecommendState>>{
      GameRecommendAction.action: _onAction,
    },
  );
}

GameRecommendState _onAction(GameRecommendState state, Action action) {
  final GameRecommendState newState = state.clone();
  return newState;
}
