import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralExpendState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralExpendState>>{
      IntegralExpendAction.action: _onAction,
      IntegralExpendAction.updateData: _updateData,
    },
  );
}

IntegralExpendState _onAction(IntegralExpendState state, Action action) {
  final IntegralExpendState newState = state.clone();
  return newState;
}

IntegralExpendState _updateData(IntegralExpendState state, Action action) {
  final IntegralExpendState newState = state.clone();
  newState.goldRecords = action.payload;
  return newState;
}
