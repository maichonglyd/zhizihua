import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCoinSelectGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCoinSelectGameState>>{
      GameCoinSelectGameAction.action: _onAction,
      GameCoinSelectGameAction.updateGameList: _updateGameList,
    },
  );
}

GameCoinSelectGameState _onAction(
    GameCoinSelectGameState state, Action action) {
  final GameCoinSelectGameState newState = state.clone();
  return newState;
}

GameCoinSelectGameState _updateGameList(
    GameCoinSelectGameState state, Action action) {
  final GameCoinSelectGameState newState = state.clone();
  newState.games = action.payload;
  return newState;
}
