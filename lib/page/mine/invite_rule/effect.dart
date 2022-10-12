import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<InviteRuleState> buildEffect() {
  return combineEffects(<Object, Effect<InviteRuleState>>{
    InviteRuleAction.action: _onAction,
  });
}

void _onAction(Action action, Context<InviteRuleState> ctx) {}
