import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PaySuccessState> buildReducer() {
  return asReducer(
    <Object, Reducer<PaySuccessState>>{
      PaySuccessAction.action: _onAction,
    },
  );
}

PaySuccessState _onAction(PaySuccessState state, Action action) {
  final PaySuccessState newState = state.clone();
  return newState;
}
