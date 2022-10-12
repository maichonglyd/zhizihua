import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameDetailsComponentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsComponentState>>{
      GameDetailsAction.action: _onAction,
      GameDetailsAction.updateComments: _updateComments,
      GameDetailsAction.createPlayController: _createPlayController,
      GameDetailsAction.createController: _createController,
    },
  );
}

GameDetailsComponentState _createController(
    GameDetailsComponentState state, Action action) {
  final GameDetailsComponentState newState = state.clone();
  newState.scrollController = action.payload['scrollController'];
  return newState;
}

GameDetailsComponentState _createPlayController(
    GameDetailsComponentState state, Action action) {
  print("GameDetailsState:_createPlayController");
  final GameDetailsComponentState newState = state.clone();
  newState.videoPlayerController = action.payload;
  return newState;
}

GameDetailsComponentState _onAction(
    GameDetailsComponentState state, Action action) {
  final GameDetailsComponentState newState = state.clone();
  return newState;
}

GameDetailsComponentState _updateComments(
    GameDetailsComponentState state, Action action) {
  final GameDetailsComponentState newState = state.clone();
  print("_updateComments");
  newState.comments = action.payload;
  return newState;
}
