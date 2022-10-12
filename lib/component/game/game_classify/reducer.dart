import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/game_type.dart' as game_type;

Reducer<GameClassifyState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameClassifyState>>{
      GameClassifyAction.action: _onAction,
      GameClassifyAction.updateGameType: _updateGameType,
      GameClassifyAction.updateIndex: _updateIndex,
      GameClassifyAction.updateTypeIndex: _updateTypeIndex,
    },
  );
}

GameClassifyState _onAction(GameClassifyState state, Action action) {
  final GameClassifyState newState = state.clone();
  return newState;
}

GameClassifyState _updateGameType(GameClassifyState state, Action action) {
  final GameClassifyState newState = state.clone();
  newState.gameType = action.payload;
  return newState;
}

GameClassifyState _updateIndex(GameClassifyState state, Action action) {
  final GameClassifyState newState = state.clone();
  newState.index = action.payload;
  return newState;
}

GameClassifyState _updateTypeIndex(GameClassifyState state, Action action) {
  final GameClassifyState newState = state.clone();
  newState.typeIndex = action.payload;
  return newState;
}
