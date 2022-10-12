import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<InviteRuleState> buildReducer() {
  return asReducer(
    <Object, Reducer<InviteRuleState>>{
      InviteRuleAction.action: _onAction,
    },
  );
}

InviteRuleState _onAction(InviteRuleState state, Action action) {
  final InviteRuleState newState = state.clone();
  return newState;
}
