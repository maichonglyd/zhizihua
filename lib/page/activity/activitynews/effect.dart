import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ActivityNewsState> buildEffect() {
  return combineEffects(<Object, Effect<ActivityNewsState>>{
    ActivityNewsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ActivityNewsState> ctx) {}
