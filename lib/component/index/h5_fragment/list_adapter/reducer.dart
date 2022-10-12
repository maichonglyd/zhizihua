import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';

import '../state.dart';
import 'action.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<H5FragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<H5FragmentState>>{
      BtAdapterAction.update: _update,
    },
  );
}

H5FragmentState _onAction(H5FragmentState state, Action action) {
  final H5FragmentState newState = state.clone();
  return newState;
}

H5FragmentState _update(H5FragmentState state, Action action) {
  final H5FragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  newState.indexBannerState = IndexBannerState()
    ..gameBannerItems = data.homeTopper.list;
  newState.indexRowGameState = IndexRowGameState()..games = data.rmdGame.list;
  return newState;
}
