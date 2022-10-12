import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<GameDetailsDealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsDealFragmentState>>{
      DealListAction.action: _onAction,
    },
  );
}

GameDetailsDealFragmentState _onAction(
    GameDetailsDealFragmentState state, Action action) {
  final GameDetailsDealFragmentState newState = state.clone();
  return newState;
}
