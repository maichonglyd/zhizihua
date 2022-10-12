import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/new_game_tip/state.dart';

import '../state.dart';
import 'action.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<ZKFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<ZKFragmentState>>{
      BtAdapterAction.update: _update,
    },
  );
}

ZKFragmentState _onAction(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  return newState;
}

ZKFragmentState _update(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  newState.indexBannerState = IndexBannerState()
    ..gameBannerItems = data.homeTopper.list;
  newState.indexRowGameState = IndexRowGameState()..games = data.rmdGame.list;
  newState.newGameTipState = NewGameTipState()..games = data.rmdGame.list;
  return newState;
}
