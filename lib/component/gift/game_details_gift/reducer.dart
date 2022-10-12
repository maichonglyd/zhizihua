import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameDetailsGiftFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsGiftFragmentState>>{
      GameDetailsGiftFragmentAction.action: _onAction,
      GameDetailsGiftFragmentAction.updateGifts: _updateGifts,
    },
  );
}

GameDetailsGiftFragmentState _onAction(
    GameDetailsGiftFragmentState state, Action action) {
  final GameDetailsGiftFragmentState newState = state.clone();
  return newState;
}

GameDetailsGiftFragmentState _updateGifts(
    GameDetailsGiftFragmentState state, Action action) {
  final GameDetailsGiftFragmentState newState = state.clone();

  newState.gifts = action.payload;
  return newState;
}
