import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<MyGiftState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyGiftState>>{
      MyGiftLiatAdapterAction.action: _onAction,
    },
  );
}

MyGiftState _onAction(MyGiftState state, Action action) {
  final MyGiftState newState = state.clone();
  return newState;
}
