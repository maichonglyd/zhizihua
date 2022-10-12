import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameQualitySelectState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameQualitySelectState>>{
      GameQualitySelectAction.action: _onAction,
    },
  );
}

GameQualitySelectState _onAction(GameQualitySelectState state, Action action) {
  final GameQualitySelectState newState = state.clone();
  return newState;
}
