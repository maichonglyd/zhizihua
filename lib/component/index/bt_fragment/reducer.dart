import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as index_select_tab;
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<BtFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<BtFragmentState>>{
      BtFragmentAction.action: _onAction,
      BtFragmentAction.createController: _createController,
      BtFragmentAction.updateHomeData: _updateHomeData,
      BtFragmentAction.switchData: _switchData,
      BtFragmentAction.createScrollController: _createScrollController,
      BtFragmentAction.updateCardGame: _updateCardGame,
      BtFragmentAction.updateTopTabList: _updateTopTabList,
    },
  );
}

BtFragmentState _createScrollController(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
  newState..scrollController = action.payload;
//  HuoLog.d("bt set scrollController=${action.payload}");
  return newState;
}

BtFragmentState _onAction(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
  return newState;
}

BtFragmentState _switchData(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
  newState.switchData = action.payload;
  return newState;
}

BtFragmentState _createController(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
  newState..tabController = action.payload;
  return newState;
}

BtFragmentState _updateHomeData(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  if (data.homeTopper != null) {
    bool hasVideo = false;
    if (data.homeTopper.list != null) {
      for (GameBannerItem item in data.homeTopper.list) {
        if (item.typeName == "game" &&
            item.url.isNotEmpty &&
            item.url != null) {
          hasVideo = true;
          break;
        } else {
          continue;
        }
      }
    }
    print("hasVideo: $hasVideo");
    newState.indexBannerState
      ..gameBannerItems = data.homeTopper.list
      ..news = newState.news
      ..isShowVolume = newState.isShowVolume
      ..hasVideo = hasVideo;
  }

  if (data.appIndexTextList != null && data.appIndexTextList.list.length > 0) {
    List<AppIndexTextListData> homeNotice = data.appIndexTextList.list;
    if (data.appIndexTextList.list.length > 0) {
      homeNotice.add(data.appIndexTextList.list[0]);
      homeNotice.add(data.appIndexTextList.list[1]);
      homeNotice.add(data.appIndexTextList.list[2]);
    }
    newState.indexNewsState = IndexNewsState()..news = homeNotice;
  } else {
    newState.indexNewsState = IndexNewsState()
      ..news = data.appIndexTextList.list;
  }

  if (data.homeNotice != null && data.homeNotice.length > 0) {
    newState.newActivityState = NewActivityState()..news = data.homeNotice;
  }

  newState.indexRowGameState = IndexRowGameState()
    ..games = data.rmdGame.list
    ..showLine = false;

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

BtFragmentState _updateCardGame(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
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

BtFragmentState _updateTopTabList(BtFragmentState state, Action action) {
  final BtFragmentState newState = state.clone();
  newState.topTabList = action.payload;
  return newState;
}
