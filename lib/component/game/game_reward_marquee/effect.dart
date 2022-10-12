import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameRewardMarqueeState> buildEffect() {
  return combineEffects(<Object, Effect<GameRewardMarqueeState>>{
    GameRewardMarqueeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameRewardMarqueeState> ctx) {
}
