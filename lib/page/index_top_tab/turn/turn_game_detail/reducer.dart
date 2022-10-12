import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TurnGameDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<TurnGameDetailState>>{
      TurnGameDetailAction.action: _onAction,
      TurnGameDetailAction.updateData: _updateData,
      TurnGameDetailAction.updateBottomButton: _updateBottomButton,
    },
  );
}

TurnGameDetailState _onAction(TurnGameDetailState state, Action action) {
  final TurnGameDetailState newState = state.clone();
  return newState;
}

TurnGameDetailState _updateData(TurnGameDetailState state, Action action) {
  final TurnGameDetailState newState = state.clone();
  newState.turnGameDetailModel = action.payload;
  return newState;
}

TurnGameDetailState _updateBottomButton(TurnGameDetailState state, Action action) {
  final TurnGameDetailState newState = state.clone();
  newState.isHas = action.payload;
  return newState;
}
