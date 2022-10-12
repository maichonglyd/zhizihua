import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FindPasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<FindPasswordState>>{
      FindPasswordAction.action: _onAction,
      FindPasswordAction.nextStep: _nextStep,
      FindPasswordAction.updateDownTime: _updateDownTime,
    },
  );
}

FindPasswordState _onAction(FindPasswordState state, Action action) {
  final FindPasswordState newState = state.clone();
  return newState;
}

FindPasswordState _nextStep(FindPasswordState state, Action action) {
  final FindPasswordState newState = state.clone();
//  newState.step = state.step<2?++state.step:0;
  int step = state.step;
  String mobile;
  String verifyToken;
  if (step == 0) {
    mobile = action.payload['mobile'];
    verifyToken = action.payload['verify_token'];
  } else if (step == 1) {
    verifyToken = action.payload;
  }
  newState.step = ++step;
  newState.bindMobile = mobile;
  newState.verifyToken = verifyToken;
  return newState;
}

FindPasswordState _updateDownTime(FindPasswordState state, Action action) {
  final FindPasswordState newState = state.clone();
  newState.countdownTime = action.payload;
  return newState;
}
