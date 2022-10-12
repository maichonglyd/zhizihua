import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealFilterState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealFilterState>>{
      PropDealFilterAction.action: _onAction,
      PropDealFilterAction.updateGame: _updateGame,
      PropDealFilterAction.selectServer: _selectServer,
      PropDealFilterAction.deleteGame: _deleteGame,
      PropDealFilterAction.updateSortType: _updateSortType,
    },
  );
}

PropDealFilterState _onAction(PropDealFilterState state, Action action) {
  print("logcat: line 18");
  final PropDealFilterState newState = state.clone();
  return newState;
}

PropDealFilterState _deleteGame(PropDealFilterState state, Action action) {
  final PropDealFilterState newState = state.clone();
  newState.playedGame = null;
  return newState;
}

PropDealFilterState _selectServer(PropDealFilterState state, Action action) {
  final PropDealFilterState newState = state.clone();
  newState.curServer = action.payload;
  return newState;
}

PropDealFilterState _updateGame(PropDealFilterState state, Action action) {
  final PropDealFilterState newState = state.clone();
  newState.playedGame = action.payload;
  print("_updateGame=======:${newState.playedGame.gameName}");
  return newState;
}

PropDealFilterState _updateSortType(PropDealFilterState state, Action action) {
  print("logcat: line 18");
  final PropDealFilterState newState = state.clone();
  newState.sortType = action.payload;
  return newState;
}
