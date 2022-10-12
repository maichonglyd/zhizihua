import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealItemTitleState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealItemTitleState>>{
      DealItemTitleAction.action: _onAction,
      DealItemTitleAction.updateType: _updateType,
    },
  );
}

DealItemTitleState _onAction(DealItemTitleState state, Action action) {
  final DealItemTitleState newState = state.clone();
  return newState;
}

DealItemTitleState _updateType(DealItemTitleState state, Action action) {
  final DealItemTitleState newState = state.clone();
  newState.typeIndex = action.payload;
  return newState;
}
