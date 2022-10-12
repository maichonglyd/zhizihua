import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameHotListState> buildEffect() {
  return combineEffects(<Object, Effect<GameHotListState>>{
    GameHotListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameHotListState> ctx) {
}
