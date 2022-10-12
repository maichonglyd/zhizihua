import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/state.dart';

Effect<RebateApplyState> buildEffect() {
  return combineEffects(<Object, Effect<RebateApplyState>>{
    RebateGameListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RebateApplyState> ctx) {}
