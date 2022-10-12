import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/utils/fragment_util.dart';

import 'action.dart';
import 'state.dart';

Reducer<ClassifyState> buildReducer() {
  return asReducer(
    <Object, Reducer<ClassifyState>>{
      ClassifyAction.action: _onAction,
      ClassifyAction.updateLeftTabs: _updateLeftTabs,
      ClassifyAction.updateRightGames: _updateRightGames,
//      ClassifyAction.onSelectedTabs: _onSelectedTabs,
      ClassifyAction.updateSelectTypeId: _updateSelectTypeId,
    },
  );
}

ClassifyState _updateGame(ClassifyState state, Action action) {
  final ClassifyState newState = state.clone();
  newState.game = action.payload;
  return newState;
}

ClassifyState _updateRightGames(ClassifyState state, Action action) {
  final ClassifyState newState = state.clone();
  newState.games = action.payload;
  print("games:${action.payload.toString()}");
  return newState;
}

ClassifyState _updateSelectTypeId(ClassifyState state, Action action) {
  final ClassifyState newState = state.clone();
  newState.selectTypeId = action.payload;
  return newState;
}

//ClassifyState _onSelectedTabs(ClassifyState state, Action action) {
//  final ClassifyState newState = state.clone();
//  newState.tabs = action.payload;
//  return newState;
//}

ClassifyState _updateLeftTabs(ClassifyState state, Action action) {
  final ClassifyState newState = state.clone();
  newState.tabs = action.payload["tabs"];
  newState.selectTypeId = action.payload["typeId"];
  print("_updateLeftTabs${action.payload.toString()}");
  FragmentConstant.classifySelectTypeId = 0;
  return newState;
}

ClassifyState _onAction(ClassifyState state, Action action) {
  final ClassifyState newState = state.clone();
  return newState;
}
