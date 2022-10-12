import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SecurityState> buildReducer() {
  return asReducer(
    <Object, Reducer<SecurityState>>{
      SecurityAction.action: _onAction,
      SecurityAction.update: _update,
    },
  );
}

SecurityState _onAction(SecurityState state, Action action) {
  final SecurityState newState = state.clone();
  return newState;
}

SecurityState _update(SecurityState state, Action action) {
  final SecurityState newState = state.clone();
  newState.serviceInfo = action.payload;
  return newState;
}
