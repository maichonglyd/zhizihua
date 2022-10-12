import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameStrategyMoneyState> buildEffect() {
  return combineEffects(<Object, Effect<GameStrategyMoneyState>>{
    GameStrategyMoneyAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameStrategyMoneyState> ctx) {
}
