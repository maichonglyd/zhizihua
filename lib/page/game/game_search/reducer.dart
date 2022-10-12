import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameSearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSearchState>>{
      GameSearchAction.action: _onAction,
      GameSearchAction.updateGameList: _updateGameList,
      GameSearchAction.updateHistory: _updateHistory,
      GameSearchAction.updateHotGameList: _updateHotGameList,
    },
  );
}

GameSearchState _onAction(GameSearchState state, Action action) {
  final GameSearchState newState = state.clone();
  return newState;
}

GameSearchState _updateGameList(GameSearchState state, Action action) {
  final GameSearchState newState = state.clone();
  newState.games = action.payload;
  return newState;
}

GameSearchState _updateHistory(GameSearchState state, Action action) {
  final GameSearchState newState = state.clone();
  newState.gameHistoryList = action.payload;
  return newState;
}

GameSearchState _updateHotGameList(GameSearchState state, Action action) {
  final GameSearchState newState = state.clone();
  newState.hotGames = action.payload;
  return newState;
}
