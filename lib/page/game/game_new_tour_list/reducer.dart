import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameNewTourListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameNewTourListState>>{
      GameNewTourListAction.action: _onAction,
      GameNewTourListAction.updateData: _updateData,
    },
  );
}

GameNewTourListState _onAction(GameNewTourListState state, Action action) {
  final GameNewTourListState newState = state.clone();
  return newState;
}

GameNewTourListState _updateData(GameNewTourListState state, Action action) {
  final GameNewTourListState newState = state.clone();
  int type = action.payload['type'];
  List<Game> list = action.payload['list'];
  switch (type) {
    case GameNewTourListState.gameNewTourListTypeWeekend:
      newState.firstGameList = list;
      newState.firstGameNewRoundListState..gameList = list;
      break;
    case GameNewTourListState.gameNewTourListTypeComment:
      newState.secondGameList = list;
      newState.secondGameNewRoundListState..gameList = list;
      break;
    case GameNewTourListState.gameNewTourListTypeOrder:
      newState.thirdGameList = list;
      newState.thirdGameNewRoundListState..gameList = list;
      break;
  }
  return newState;
}
