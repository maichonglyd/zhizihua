import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ActivityHomeState> buildEffect() {
  return combineEffects(<Object, Effect<ActivityHomeState>>{
    ActivityHomeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ActivityHomeState> ctx) {}
