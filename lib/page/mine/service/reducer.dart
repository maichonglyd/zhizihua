import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ServiceState> buildReducer() {
  return asReducer(
    <Object, Reducer<ServiceState>>{
      ServiceAction.action: _onAction,
      ServiceAction.update: _update,
    },
  );
}

ServiceState _onAction(ServiceState state, Action action) {
  final ServiceState newState = state.clone();
  return newState;
}

ServiceState _update(ServiceState state, Action action) {
  final ServiceState newState = state.clone();
  newState.serviceInfo = action.payload;
  return newState;
}
