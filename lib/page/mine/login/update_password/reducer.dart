import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UpdatePasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<UpdatePasswordState>>{
      UpdatePasswordAction.action: _onAction,
    },
  );
}

UpdatePasswordState _onAction(UpdatePasswordState state, Action action) {
  final UpdatePasswordState newState = state.clone();
  return newState;
}
