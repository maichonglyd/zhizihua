import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameNewBannerState> buildEffect() {
  return combineEffects(<Object, Effect<GameNewBannerState>>{
    GameNewBannerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameNewBannerState> ctx) {
}
