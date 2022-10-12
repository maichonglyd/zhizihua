import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountRecycleTipState> buildEffect() {
  return combineEffects(<Object, Effect<AccountRecycleTipState>>{
    AccountRecycleTipAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AccountRecycleTipState> ctx) {}
