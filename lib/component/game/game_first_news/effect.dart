import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameFirstNewsState> buildEffect() {
  return combineEffects(<Object, Effect<GameFirstNewsState>>{
    GameFirstNewsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameFirstNewsState> ctx) {
}
