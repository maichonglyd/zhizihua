import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameRecommendState> buildEffect() {
  return combineEffects(<Object, Effect<GameRecommendState>>{
    GameRecommendAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameRecommendState> ctx) {
}
