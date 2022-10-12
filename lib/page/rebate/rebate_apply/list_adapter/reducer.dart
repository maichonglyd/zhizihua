import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/state.dart';

Reducer<RebateApplyState> buildReducer() {
  return asReducer(
    <Object, Reducer<RebateApplyState>>{
      RebateGameListAction.action: _onAction,
    },
  );
}

RebateApplyState _onAction(RebateApplyState state, Action action) {
  final RebateApplyState newState = state.clone();
  return newState;
}
