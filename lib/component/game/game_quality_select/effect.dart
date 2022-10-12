import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameQualitySelectState> buildEffect() {
  return combineEffects(<Object, Effect<GameQualitySelectState>>{
    GameQualitySelectAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameQualitySelectState> ctx) {
}
