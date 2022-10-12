import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RechargeInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<RechargeInfoState>>{
      RechargeInfoAction.action: _onAction,
    },
  );
}

RechargeInfoState _onAction(RechargeInfoState state, Action action) {
  final RechargeInfoState newState = state.clone();
  return newState;
}
