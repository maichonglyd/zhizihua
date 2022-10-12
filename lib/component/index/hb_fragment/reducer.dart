import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/game/game_reward_banner/state.dart'
    as game_reward_banner;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as index_select_tab;

import 'action.dart';
import 'state.dart';

Reducer<HbFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<HbFragmentState>>{
      HbFragmentAction.action: _onAction,
      HbFragmentAction.createScrollController: _createScrollController,
      HbFragmentAction.isShowBackTop: _isShowBackTop,
      HbFragmentAction.updateHomeData: _updateHomeData,
      HbFragmentAction.updateCardGame: _updateCardGame,
      HbFragmentAction.updateSwitchSelectIndex: _updateSwitchSelectIndex,
    },
  );
}

HbFragmentState _onAction(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  return newState;
}

HbFragmentState _isShowBackTop(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  newState.showBackTop = action.payload;
  return newState;
}

HbFragmentState _createScrollController(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  newState..scrollController = action.payload;
  return newState;
}

HbFragmentState _updateHomeData(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  if (data.homeTopper != null) {
    bool hasVideo = false;
    if (data.homeTopper.list != null) {
      newState.bannerState = game_reward_banner.initState(data.homeTopper.list);
    }
  }

  for (GameSpecial gameSpecial in data.specialList.list) {
    if (gameSpecial.styleType == 9 &&
        null != gameSpecial.gameListArray &&
        gameSpecial.gameListArray.length > 0) {
      List<String> tabs = List();
      for (GameListBean game in gameSpecial.gameListArray) {
        tabs.add(game.title);
      }
      if (null == newState.indexSelectTabState) {
        newState.indexSelectTabState = index_select_tab.initState(tabs);
      } else {
        newState.indexSelectTabState..tabs = tabs;
      }
    }
  }

  return newState;
}

HbFragmentState _updateCardGame(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  num topicId = action.payload['topicId'];
  List<Game> gameList = action.payload['gameList'];
  int cardPage = action.payload['cardPage'];
  for (int i = 0; i < newState.homeData.specialList.list.length; i++) {
    if (topicId == newState.homeData.specialList.list[i].topicId) {
      newState.homeData.specialList.list[i].gameList = gameList;
      newState.cardPage = cardPage;
    }
  }
  return newState;
}

HbFragmentState _updateSwitchSelectIndex(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  newState..switchSelectIndex = action.payload;
  return newState;
}
