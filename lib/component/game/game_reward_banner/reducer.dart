import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameRewardBannerState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameRewardBannerState>>{
      GameRewardBannerAction.action: _onAction,
    },
  );
}

GameRewardBannerState _onAction(GameRewardBannerState state, Action action) {
  final GameRewardBannerState newState = state.clone();
  return newState;
}
