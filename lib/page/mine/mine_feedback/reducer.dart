import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FeedbackState> buildReducer() {
  return asReducer(
    <Object, Reducer<FeedbackState>>{
      FeedbackAction.action: _onAction,
      FeedbackAction.update: _update,
    },
  );
}

FeedbackState _onAction(FeedbackState state, Action action) {
  final FeedbackState newState = state.clone();
  return newState;
}

FeedbackState _update(FeedbackState state, Action action) {
  final FeedbackState newState = state.clone();
  return newState;
}
