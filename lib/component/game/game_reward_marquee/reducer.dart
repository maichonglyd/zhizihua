import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRewardMarqueeState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRewardMarqueeState>>{
      GameRewardMarqueeAction.action: _onAction,
    },
  );
}

GameRewardMarqueeState _onAction(GameRewardMarqueeState state, Action action) {
  final GameRewardMarqueeState newState = state.clone();
  return newState;
}
