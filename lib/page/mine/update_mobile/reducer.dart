import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UpdateMobileState> buildReducer() {
  return asReducer(
    <Object, Reducer<UpdateMobileState>>{
      UpdateMobileAction.action: _onAction,
      UpdateMobileAction.updateDownTime: _updateDownTime,
    },
  );
}

UpdateMobileState _onAction(UpdateMobileState state, Action action) {
  final UpdateMobileState newState = state.clone();
  return newState;
}

UpdateMobileState _updateDownTime(UpdateMobileState state, Action action) {
  final UpdateMobileState newState = state.clone();
  newState.countdownTime = action.payload;
  return newState;
}
