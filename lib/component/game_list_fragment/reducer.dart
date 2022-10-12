import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameListState>>{
      GameListAction.action: _onAction,
      GameListAction.updateGameList: _updateGameList,
      GameListAction.updateTagId: _updateTagId,
      GameListAction.updateType: _updateType,
    },
  );
}

GameListState _onAction(GameListState state, Action action) {
  final GameListState newState = state.clone();
  return newState;
}

GameListState _updateType(GameListState state, Action action) {
  final GameListState newState = state.clone();
  newState.type = action.payload;
  return newState;
}

GameListState _updateTagId(GameListState state, Action action) {
  final GameListState newState = state.clone();
  newState.type = action.payload["type"];
  newState.tagId = action.payload["tagId"];
  return newState;
}

GameListState _updateGameList(GameListState state, Action action) {
  print("GameListAction.updateGameList" + state.hashCode.toString());
  final GameListState newState = state.clone();
  newState.games = action.payload;
  return newState;
}
