import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealFragmentState>>{
      DealFragmentAction.action: _onAction,
      DealFragmentAction.crateTabController: _crateTabController,
      DealFragmentAction.switchIndex: _switchIndex,
    },
  );
}

DealFragmentState _onAction(DealFragmentState state, Action action) {
  final DealFragmentState newState = state.clone();
  return newState;
}

DealFragmentState _switchIndex(DealFragmentState state, Action action) {
  final DealFragmentState newState = state.clone();
  newState.index = action.payload;
  if (newState.tabController.index != newState.index)
    newState.tabController.index = newState.index;
  return newState;
}

DealFragmentState _crateTabController(DealFragmentState state, Action action) {
  final DealFragmentState newState = state.clone();
  newState.tabController = action.payload;
  return newState;
}
