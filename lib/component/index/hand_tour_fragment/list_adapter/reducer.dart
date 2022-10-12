import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

import '../state.dart';
import 'action.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<HtFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<HtFragmentState>>{
      HtAdapterAction.update: _update,
    },
  );
}

HtFragmentState _onAction(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
  return newState;
}

HtFragmentState _update(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  newState.indexBannerState = IndexBannerState()
    ..gameBannerItems = data.homeTopper.list;

  if (data.appIndexTextList != null && data.appIndexTextList.list.length < 2) {
    List<AppIndexTextListData> homeNotice = data.appIndexTextList.list;
    homeNotice.add(data.appIndexTextList.list[0]);
    homeNotice.add(data.appIndexTextList.list[1]);
    homeNotice.add(data.appIndexTextList.list[2]);
    newState.indexNewsState = IndexNewsState()..news = homeNotice;
  } else {
    newState.indexNewsState = IndexNewsState()
      ..news = data.appIndexTextList.list;
  }

  if (data.homeNotice != null) {
    newState.newActivityState = NewActivityState()..news = data.homeNotice;
  }

  newState.indexRowGameState = IndexRowGameState()..games = data.rmdGame.list;
  return newState;
}
