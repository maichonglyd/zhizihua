import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<DealSearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealSearchState>>{
      ListAdapterAction.action: _onAction,
    },
  );
}

DealSearchState _onAction(DealSearchState state, Action action) {
  final DealSearchState newState = state.clone();
  return newState;
}
