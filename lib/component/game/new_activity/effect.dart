import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NewActivityState> buildEffect() {
  return combineEffects(<Object, Effect<NewActivityState>>{
    NewActivityAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NewActivityState> ctx) {}
