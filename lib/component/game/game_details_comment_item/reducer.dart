import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCommentItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCommentItemState>>{
      GameCommentItemAction.action: _onAction,
    },
  );
}

GameCommentItemState _onAction(GameCommentItemState state, Action action) {
  final GameCommentItemState newState = state.clone();
  return newState;
}
