import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PtbExpenseState> buildReducer() {
  return asReducer(
    <Object, Reducer<PtbExpenseState>>{
      PtbExpenseAction.action: _onAction,
      PtbExpenseAction.update: _update,
    },
  );
}

PtbExpenseState _onAction(PtbExpenseState state, Action action) {
  final PtbExpenseState newState = state.clone();
  return newState;
}

PtbExpenseState _update(PtbExpenseState state, Action action) {
  final PtbExpenseState newState = state.clone();
  newState.consumes = action.payload;
  return newState;
}
