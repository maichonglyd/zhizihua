import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameRewardSelectState> buildEffect() {
  return combineEffects(<Object, Effect<GameRewardSelectState>>{
    GameRewardSelectAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameRewardSelectState> ctx) {
}
