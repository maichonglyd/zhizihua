import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ActivityHomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<ActivityHomeState>>{
      ActivityHomeAction.action: _onAction,
    },
  );
}

ActivityHomeState _onAction(ActivityHomeState state, Action action) {
  final ActivityHomeState newState = state.clone();
  return newState;
}
