import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountRecycleSuccessState> buildEffect() {
  return combineEffects(<Object, Effect<AccountRecycleSuccessState>>{
    AccountRecycleSuccessAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AccountRecycleSuccessState> ctx) {}
