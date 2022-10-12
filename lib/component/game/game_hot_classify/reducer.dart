import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameHotClassifyState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameHotClassifyState>>{
      GameHotClassifyAction.action: _onAction,
    },
  );
}

GameHotClassifyState _onAction(GameHotClassifyState state, Action action) {
  final GameHotClassifyState newState = state.clone();
  return newState;
}
