import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PtzIncomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<PtzIncomeState>>{
      PtzIncomeAction.action: _onAction,
      PtzIncomeAction.updateData: _updateData,
    },
  );
}

PtzIncomeState _onAction(PtzIncomeState state, Action action) {
  final PtzIncomeState newState = state.clone();
  return newState;
}

PtzIncomeState _updateData(PtzIncomeState state, Action action) {
  final PtzIncomeState newState = state.clone();
  newState.records = action.payload;
  return newState;
}
