import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameGiftState> buildEffect() {
  return combineEffects(<Object, Effect<GameGiftState>>{
    GameGiftAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameGiftState> ctx) {
}
