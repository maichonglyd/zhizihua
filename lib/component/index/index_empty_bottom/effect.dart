import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexEmptyBottomState> buildEffect() {
  return combineEffects(<Object, Effect<IndexEmptyBottomState>>{
    IndexEmptyBottomAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IndexEmptyBottomState> ctx) {
}
