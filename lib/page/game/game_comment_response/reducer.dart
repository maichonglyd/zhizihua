import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCommentResponseState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCommentResponseState>>{
      GameCommentResponseAction.action: _onAction,
      GameCommentResponseAction.updateData: _updateData,
    },
  );
}

GameCommentResponseState _onAction(GameCommentResponseState state, Action action) {
  final GameCommentResponseState newState = state.clone();
  return newState;
}

GameCommentResponseState _updateData(GameCommentResponseState state, Action action) {
  final GameCommentResponseState newState = state.clone();
  newState.commentList = action.payload;
  return newState;
}
