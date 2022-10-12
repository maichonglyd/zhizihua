import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterPageState>>{
      RegisterPageAction.action: _onAction,
      RegisterPageAction.switchRegisterType: _switchRegisterType,
      RegisterPageAction.updateDownTime: _updateDownTime,
    },
  );
}

RegisterPageState _onAction(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  return newState;
}

RegisterPageState _switchRegisterType(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  newState.isPhone = !state.isPhone;
  return newState;
}

RegisterPageState _updateDownTime(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  newState.countdownTime = action.payload;
  return newState;
}
