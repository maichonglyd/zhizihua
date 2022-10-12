import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<DealSearchState> buildEffect() {
  return combineEffects(<Object, Effect<DealSearchState>>{
    ListAdapterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DealSearchState> ctx) {}
