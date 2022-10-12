import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VIPPrivilegeState> buildReducer() {
  return asReducer(
    <Object, Reducer<VIPPrivilegeState>>{
      VIPPrivilegeAction.action: _onAction,
    },
  );
}

VIPPrivilegeState _onAction(VIPPrivilegeState state, Action action) {
  final VIPPrivilegeState newState = state.clone();
  return newState;
}
