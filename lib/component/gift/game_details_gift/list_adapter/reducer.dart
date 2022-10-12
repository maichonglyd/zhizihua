import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<GameDetailsGiftFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsGiftFragmentState>>{
      GiftListAction.action: _onAction,
    },
  );
}

GameDetailsGiftFragmentState _onAction(
    GameDetailsGiftFragmentState state, Action action) {
  final GameDetailsGiftFragmentState newState = state.clone();
  return newState;
}
