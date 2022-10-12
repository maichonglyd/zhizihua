import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCommitCommentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCommitCommentState>>{
      GameCommitCommentAction.action: _onAction,
      GameCommitCommentAction.changeNum: _changeNum,
    },
  );
}

GameCommitCommentState _onAction(GameCommitCommentState state, Action action) {
  final GameCommitCommentState newState = state.clone();
  return newState;
}

GameCommitCommentState _changeNum(GameCommitCommentState state, Action action) {
  final GameCommitCommentState newState = state.clone();
  newState.starNum = action.payload + 1;
  return newState;
}
