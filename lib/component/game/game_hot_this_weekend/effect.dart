import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameHotThisWeekendState> buildEffect() {
  return combineEffects(<Object, Effect<GameHotThisWeekendState>>{
    GameHotThisWeekendAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameHotThisWeekendState> ctx) {
}
