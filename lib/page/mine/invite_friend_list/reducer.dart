import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<InviteListState> buildReducer() {
  return asReducer(
    <Object, Reducer<InviteListState>>{
      InviteListAction.action: _onAction,
      InviteListAction.update: _update,
    },
  );
}

InviteListState _onAction(InviteListState state, Action action) {
  final InviteListState newState = state.clone();
  return newState;
}

InviteListState _update(InviteListState state, Action action) {
  final InviteListState newState = state.clone();
  newState.mems = action.payload;
  return newState;
}
