import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameHotListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameHotListState>>{
      GameHotListAction.action: _onAction,
    },
  );
}

GameHotListState _onAction(GameHotListState state, Action action) {
  final GameHotListState newState = state.clone();
  return newState;
}
