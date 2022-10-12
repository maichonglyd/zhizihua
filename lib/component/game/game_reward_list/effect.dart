import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameRewardListState> buildEffect() {
  return combineEffects(<Object, Effect<GameRewardListState>>{
    GameRewardListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameRewardListState> ctx) {
}
