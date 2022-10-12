import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameFirstRoundState> buildEffect() {
  return combineEffects(<Object, Effect<GameFirstRoundState>>{
    GameFirstRoundAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameFirstRoundState> ctx) {
}
