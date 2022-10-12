import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealSellSelectGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealSellSelectGameState>>{
      DealSellSelectGameAction.action: _onAction,
    },
  );
}

DealSellSelectGameState _onAction(
    DealSellSelectGameState state, Action action) {
  final DealSellSelectGameState newState = state.clone();
  return newState;
}
