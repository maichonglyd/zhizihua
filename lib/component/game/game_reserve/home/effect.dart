import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NewGameReserveState> buildEffect() {
  return combineEffects(<Object, Effect<NewGameReserveState>>{
    NewGameReserveAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NewGameReserveState> ctx) {}
