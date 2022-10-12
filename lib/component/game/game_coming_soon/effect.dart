import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameComingSoonState> buildEffect() {
  return combineEffects(<Object, Effect<GameComingSoonState>>{
    GameComingSoonAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameComingSoonState> ctx) {
}
