import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<GmFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GmFragmentState>>{
      GmFragmentAction.action: _onAction,
      GmFragmentAction.createController: _createController,
      GmFragmentAction.updateHomeData: _updateHomeData,
    },
  );
}

GmFragmentState _onAction(GmFragmentState state, Action action) {
  final GmFragmentState newState = state.clone();
  return newState;
}

GmFragmentState _createController(GmFragmentState state, Action action) {
  print("GmFragmentState:_onAction_createController");
  final GmFragmentState newState = state.clone();
  newState..tabController = action.payload;
  return newState;
}

GmFragmentState _updateHomeData(GmFragmentState state, Action action) {
  final GmFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;

  if (data.homeTopper != null) {
    newState.indexBannerState = IndexBannerState()
      ..gameBannerItems = data.homeTopper.list;
  } else {
    newState.indexBannerState = null;
  }
  return newState;
}
