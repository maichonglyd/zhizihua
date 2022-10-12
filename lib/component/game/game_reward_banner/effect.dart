import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameRewardBannerState> buildEffect() {
  return combineEffects(<Object, Effect<GameRewardBannerState>>{
    GameRewardBannerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameRewardBannerState> ctx) {
}
