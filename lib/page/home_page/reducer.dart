import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(<Object, Reducer<HomeState>>{
    HomeAction.updateLoadOK: _updateLoadOK,
    HomeAction.initError: _initError,
    HomeAction.changeTab: _changeTab,
    HomeAction.createController: _createController,
    HomeAction.updateHomeTabs: _updateHomeTabs,
    HomeAction.updateDownCount: _updateDownCount,
    HomeAction.showTab: _showTab,
    HomeAction.showTabFalse: _showTabFalse,
    HomeAction.updateProtocolStatus: _updateProtocolStatus,
    Lifecycle.dispose: _dispose,
  });
}

HomeState _updateLoadOK(HomeState state, Action action) {
  HuoLog.d("home page updateLoadOK");
  return state.clone()..loadStatus = LoadStatus.success;
}

HomeState _initError(HomeState state, Action action) {
  HuoLog.d("home page _initError");
  return state.clone()..loadStatus = LoadStatus.error;
}

HomeState _changeTab(HomeState state, Action action) {
  int index = action.payload;
  return state.clone()
    ..controller.index = index
    ..index = index;
}

HomeState _showTab(HomeState state, Action action) {
  return state.clone()..showTab = !state.showTab;
}

HomeState _showTabFalse(HomeState state, Action action) {
  return state.clone()..showTab = false;
}

HomeState _createController(HomeState state, Action action) {
  return state.clone()..controller = action.payload;
}

HomeState _updateHomeTabs(HomeState state, Action action) {
  return state.clone()..homeTabs = action.payload;
}

HomeState _updateDownCount(HomeState state, Action action) {
  return state.clone()..splashTime = action.payload;
}

HomeState _dispose(HomeState state, Action action) {
  state.controller.dispose();
  return null;
}

HomeState _updateProtocolStatus(HomeState state, Action action) {
  HomeState newState = state.clone();
  newState.hasAgreeProtocol = action.payload;
  return newState;
}