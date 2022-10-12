import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BindMobileState> buildReducer() {
  return asReducer(
    <Object, Reducer<BindMobileState>>{
      BindMobileAction.action: _onAction,
      BindMobileAction.updateDownTime: _updateDownTime,
    },
  );
}

BindMobileState _onAction(BindMobileState state, Action action) {
  final BindMobileState newState = state.clone();
  return newState;
}

BindMobileState _updateDownTime(BindMobileState state, Action action) {
  final BindMobileState newState = state.clone();
  newState.countdownTime = action.payload;
  return newState;
}
