import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameNewBannerState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameNewBannerState>>{
      GameNewBannerAction.action: _onAction,
    },
  );
}

GameNewBannerState _onAction(GameNewBannerState state, Action action) {
  final GameNewBannerState newState = state.clone();
  return newState;
}
