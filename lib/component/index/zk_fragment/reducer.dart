import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/component/index/new_game_tip/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as index_select_tab;

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<ZKFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<ZKFragmentState>>{
      ZKFragmentAction.action: _onAction,
      ZKFragmentAction.createController: _createController,
      ZKFragmentAction.updateHomeData: _updateHomeData,
      ZKFragmentAction.switchData: _switchData,
      ZKFragmentAction.createScrollController: _createScrollController,
      ZKFragmentAction.updateCardGame: _updateCardGame,
      ZKFragmentAction.updateTopTabList: _updateTopTabList,
    },
  );
}

ZKFragmentState _createScrollController(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  newState..scrollController = action.payload;
  return newState;
}

ZKFragmentState _onAction(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  return newState;
}

ZKFragmentState _switchData(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  newState.switchData = action.payload;
  return newState;
}

ZKFragmentState _createController(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  newState..tabController = action.payload;
  return newState;
}

ZKFragmentState _updateHomeData(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
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
    newState.indexBannerState
      ..gameBannerItems = data.homeTopper.list
      ..hasVideo = hasVideo;
  } else {
    newState.indexBannerState = null;
  }
  newState.indexRowGameState = IndexRowGameState()
    ..games = data.rmdGame.list
    ..showLine = true;
  newState.newGameTipState = NewGameTipState()..games = data.rmdGame.list;

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

ZKFragmentState _updateCardGame(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
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

ZKFragmentState _updateTopTabList(ZKFragmentState state, Action action) {
  final ZKFragmentState newState = state.clone();
  newState.topTabList = action.payload;
  return newState;
}