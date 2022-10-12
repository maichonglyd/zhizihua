import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCommentHeadState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCommentHeadState>>{
      GameCommentHeadAction.action: _onAction,
    },
  );
}

GameCommentHeadState _onAction(GameCommentHeadState state, Action action) {
  final GameCommentHeadState newState = state.clone();
  return newState;
}
