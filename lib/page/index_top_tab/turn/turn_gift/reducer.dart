import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TurnGiftState> buildReducer() {
  return asReducer(
    <Object, Reducer<TurnGiftState>>{
      TurnGiftAction.action: _onAction,
      TurnGiftAction.updateData: _updateData,
    },
  );
}

TurnGiftState _onAction(TurnGiftState state, Action action) {
  final TurnGiftState newState = state.clone();
  return newState;
}

TurnGiftState _updateData(TurnGiftState state, Action action) {
  final TurnGiftState newState = state.clone();
  newState.list = action.payload;
  print('logcat: ${newState.list.toString()}');
  return newState;
}
