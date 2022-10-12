import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexSelectTabState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexSelectTabState>>{
      IndexSelectTabAction.action: _onAction,
      IndexSelectTabAction.createController: _createController,
    },
  );
}

IndexSelectTabState _onAction(IndexSelectTabState state, Action action) {
  final IndexSelectTabState newState = state.clone();
  return newState;
}

IndexSelectTabState _createController(
    IndexSelectTabState state, Action action) {
  final IndexSelectTabState newState = state.clone();
  newState.tabController = action.payload;
  return newState;
}
