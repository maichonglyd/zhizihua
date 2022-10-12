import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import '../state.dart';

Reducer<NewGameFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewGameFragmentState>>{
      NewGameAction.action: _onAction,
    },
  );
}

NewGameFragmentState _onAction(NewGameFragmentState state, Action action) {
  final NewGameFragmentState newState = state.clone();
  return newState;
}
