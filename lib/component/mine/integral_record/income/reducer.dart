import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralIncomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralIncomeState>>{
      IntegralIncomeAction.action: _onAction,
      IntegralIncomeAction.updateData: _updateData,
    },
  );
}

IntegralIncomeState _onAction(IntegralIncomeState state, Action action) {
  final IntegralIncomeState newState = state.clone();
  return newState;
}

IntegralIncomeState _updateData(IntegralIncomeState state, Action action) {
  final IntegralIncomeState newState = state.clone();
  newState.goldRecords = action.payload;
  return newState;
}
