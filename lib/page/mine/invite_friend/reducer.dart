import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<InviteState> buildReducer() {
  return asReducer(
    <Object, Reducer<InviteState>>{
      InviteAction.action: _onAction,
      InviteAction.update: _update,
    },
  );
}

InviteState _onAction(InviteState state, Action action) {
  final InviteState newState = state.clone();
  return newState;
}

InviteState _update(InviteState state, Action action) {
  final InviteState newState = state.clone();
  newState.shareInfo = action.payload;
  return newState;
}
