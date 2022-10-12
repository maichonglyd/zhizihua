import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<VIPPrivilegeState> buildEffect() {
  return combineEffects(<Object, Effect<VIPPrivilegeState>>{
    VIPPrivilegeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<VIPPrivilegeState> ctx) {}
