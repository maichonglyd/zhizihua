import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyGiftState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyGiftState>>{
      MyGiftAction.action: _onAction,
      MyGiftAction.update: _update,
    },
  );
}

MyGiftState _onAction(MyGiftState state, Action action) {
  final MyGiftState newState = state.clone();
  return newState;
}

MyGiftState _update(MyGiftState state, Action action) {
  final MyGiftState newState = state.clone();
  newState.gifts = action.payload;
  return newState;
}
