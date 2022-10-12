import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralRecordState>>{
      IntegralRecordAction.action: _onAction,
      IntegralRecordAction.createController: _createController,
    },
  );
}

IntegralRecordState _onAction(IntegralRecordState state, Action action) {
  final IntegralRecordState newState = state.clone();
  return newState;
}

IntegralRecordState _createController(
    IntegralRecordState state, Action action) {
  final IntegralRecordState newState = state.clone();
  newState.tabController = action.payload;
  return newState;
}
