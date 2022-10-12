import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NewGameTipState> buildEffect() {
  return combineEffects(<Object, Effect<NewGameTipState>>{
    NewGameTipAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NewGameTipState> ctx) {}
