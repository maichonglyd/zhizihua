import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ExchangeRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<ExchangeRecordState>>{
      ExchangeRecordAction.action: _onAction,
      ExchangeRecordAction.updateData: _updateData,
    },
  );
}

ExchangeRecordState _onAction(ExchangeRecordState state, Action action) {
  final ExchangeRecordState newState = state.clone();
  return newState;
}

ExchangeRecordState _updateData(ExchangeRecordState state, Action action) {
  final ExchangeRecordState newState = state.clone();
  newState.list = action.payload;
  return newState;
}
