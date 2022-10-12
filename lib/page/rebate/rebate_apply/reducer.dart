import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RebateApplyState> buildReducer() {
  return asReducer(
    <Object, Reducer<RebateApplyState>>{
      RebateApplyAction.action: _onAction,
      RebateApplyAction.update: _update,
    },
  );
}

RebateApplyState _onAction(RebateApplyState state, Action action) {
  final RebateApplyState newState = state.clone();
  return newState;
}

RebateApplyState _update(RebateApplyState state, Action action) {
  final RebateApplyState newState = state.clone();
  newState.rebateGames = action.payload;
  return newState;
}
