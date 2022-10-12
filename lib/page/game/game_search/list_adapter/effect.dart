import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<GameSearchState> buildEffect() {
  return combineEffects(<Object, Effect<GameSearchState>>{
    ListAdapterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameSearchState> ctx) {}
