import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ExchangeRecordDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<ExchangeRecordDetailsState>>{
      ExchangeRecordDetailsAction.action: _onAction,
      ExchangeRecordDetailsAction.updateDetailData: _updateDetailData,
    },
  );
}

ExchangeRecordDetailsState _onAction(
    ExchangeRecordDetailsState state, Action action) {
  final ExchangeRecordDetailsState newState = state.clone();
  return newState;
}

ExchangeRecordDetailsState _updateDetailData(
    ExchangeRecordDetailsState state, Action action) {
  final ExchangeRecordDetailsState newState = state.clone();
  newState.exchangeDetail = action.payload;
  return newState;
}
