import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexPlayedItemState> buildEffect() {
  return combineEffects(<Object, Effect<IndexPlayedItemState>>{
    IndexPlayedItemAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IndexPlayedItemState> ctx) {}
