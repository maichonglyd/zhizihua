import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DealNoticeState> buildEffect() {
  return combineEffects(<Object, Effect<DealNoticeState>>{
    DealNoticeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DealNoticeState> ctx) {}
