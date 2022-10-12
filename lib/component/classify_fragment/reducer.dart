import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/utils/game_util.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassifyFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassifyFragmentState>>{
      ClassifyFragmentAction.action: _onAction,
      ClassifyFragmentAction.createController: _createController,
      ClassifyFragmentAction.updateNewGameData: _updateNewGameData,
    },
  );
}

ClassifyFragmentState _onAction(ClassifyFragmentState state, Action action) {
  final ClassifyFragmentState newState = state.clone();
  return newState;
}

ClassifyFragmentState _createController(
    ClassifyFragmentState state, Action action) {
  final ClassifyFragmentState newState = state.clone();
  newState.tabController = action.payload;
  return newState;
}

ClassifyFragmentState _updateNewGameData(
    ClassifyFragmentState state, Action action) {
  final ClassifyFragmentState newState = state.clone();
  int type = action.payload['type'];
  List<Game> list = action.payload['list'];
  switch (type) {
    case gameNewTourListTypeWeekend:
      newState.firstGameNewRoundListState..gameList = list;
      break;
    case gameNewTourListTypeComment:
      newState.secondGameNewRoundListState..gameList = list;
      break;
    case gameNewTourListTypeOrder:
      newState.thirdGameNewRoundListState..gameList = list;
      break;
  }
  return newState;
}
