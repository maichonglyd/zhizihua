import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as index_select_tab;

import 'action.dart';
import 'state.dart';

Reducer<NewGameFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewGameFragmentState>>{
      NewGameFragmentAction.action: _onAction,
      NewGameFragmentAction.createScrollController: _createScrollController,
      NewGameFragmentAction.updateHomeData: _updateHomeData,
      NewGameFragmentAction.updateCardGame: _updateCardGame,
      NewGameFragmentAction.updateSwitchSelectIndex: _updateSwitchSelectIndex,
    },
  );
}

NewGameFragmentState _onAction(NewGameFragmentState state, Action action) {
  final NewGameFragmentState newState = state.clone();
  return newState;
}

NewGameFragmentState _createScrollController(
    NewGameFragmentState state, Action action) {
  final NewGameFragmentState newState = state.clone();
  newState..scrollController = action.payload;
  return newState;
}

NewGameFragmentState _updateHomeData(
    NewGameFragmentState state, Action action) {
  final NewGameFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  if (data.homeTopper != null) {
    bool hasVideo = false;
    if (data.homeTopper.list != null) {
      for (GameBannerItem item in data.homeTopper.list) {
        if (item.typeName == "game" && item.url.isNotEmpty) {
          hasVideo = true;
          break;
        } else {
          continue;
        }
      }
    }
    HuoLog.d("hasVideo: $hasVideo; length = ${data.homeTopper.list.length}");
    newState.indexBannerState
      ..gameBannerItems = data.homeTopper.list
      ..isShowVolume = newState.isShowVolume
      ..hasVideo = hasVideo;
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

NewGameFragmentState _updateCardGame(
    NewGameFragmentState state, Action action) {
  final NewGameFragmentState newState = state.clone();
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

NewGameFragmentState _updateSwitchSelectIndex(
    NewGameFragmentState state, Action action) {
  final NewGameFragmentState newState = state.clone();
  newState..switchSelectIndex = action.payload;
  return newState;
}
