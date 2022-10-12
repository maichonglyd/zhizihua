import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCommunityState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCommunityState>>{
      GameCommunityAction.action: _onAction,
      GameCommunityAction.updateComment: _updateComment,
    },
  );
}

GameCommunityState _onAction(GameCommunityState state, Action action) {
  final GameCommunityState newState = state.clone();
  return newState;
}

GameCommunityState _updateComment(GameCommunityState state, Action action) {
  final GameCommunityState newState = state.clone();
  newState.comments = action.payload;
  return newState;
}
