import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GMGameFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GMGameFragmentState>>{
      GMGameFragmentAction.action: _onAction,
      GMGameFragmentAction.updateGmGameList: _updateGameList,
    },
  );
}

GMGameFragmentState _onAction(GMGameFragmentState state, Action action) {
  final GMGameFragmentState newState = state.clone();
  return newState;
}

GMGameFragmentState _updateGameList(GMGameFragmentState state, Action action) {
  print("GameListAction.updateGameList" + state.hashCode.toString());
  final GMGameFragmentState newState = state.clone();
  newState.gameList = action.payload;
  return newState;
}
