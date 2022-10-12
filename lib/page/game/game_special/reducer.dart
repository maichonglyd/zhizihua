import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameSpecialPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSpecialPageState>>{
      GameSpecialPageAction.action: _onAction,
      GameSpecialPageAction.updateList: _updateList,
      GameSpecialPageAction.updateTopicData: _updateTopicData,
    },
  );
}

GameSpecialPageState _onAction(GameSpecialPageState state, Action action) {
  final GameSpecialPageState newState = state.clone();
  newState.games = action.payload;
  return newState;
}

GameSpecialPageState _updateList(GameSpecialPageState state, Action action) {
  final GameSpecialPageState newState = state.clone();
  newState.games = action.payload;
  return newState;
}

GameSpecialPageState _updateTopicData(GameSpecialPageState state, Action action) {
  final GameSpecialPageState newState = state.clone();
  newState.topicData = action.payload;
  return newState;
}