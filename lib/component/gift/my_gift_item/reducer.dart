import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyGiftItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyGiftItemState>>{
      MyGiftItemAction.action: _onAction,
    },
  );
}

MyGiftItemState _onAction(MyGiftItemState state, Action action) {
  final MyGiftItemState newState = state.clone();
  return newState;
}
