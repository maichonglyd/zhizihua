import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewActivityState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewActivityState>>{
      NewActivityAction.action: _onAction,
    },
  );
}

NewActivityState _onAction(NewActivityState state, Action action) {
  final NewActivityState newState = state.clone();
  return newState;
}
