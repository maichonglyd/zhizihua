import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as index_select_tab;
import 'action.dart';
import 'state.dart';

Reducer<RmbFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<RmbFragmentState>>{
      RmbFragmentAction.action: _onAction,
      RmbFragmentAction.createScrollController: _createScrollController,
      RmbFragmentAction.isShowBackTop: _isShowBackTop,
      RmbFragmentAction.updateHomeData: _updateHomeData,
      RmbFragmentAction.updateCardGame: _updateCardGame,
      RmbFragmentAction.updateSwitchSelectIndex: _updateSwitchSelectIndex,
      RmbFragmentAction.updateTopTabList: _updateTopTabList,
    },
  );
}

RmbFragmentState _onAction(RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
  return newState;
}

RmbFragmentState _isShowBackTop(RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
  newState.showBackTop = action.payload;
  return newState;
}

RmbFragmentState _createScrollController(
    RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
  newState..scrollController = action.payload;
  return newState;
}

RmbFragmentState _updateHomeData(RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
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

RmbFragmentState _updateCardGame(RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
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

RmbFragmentState _updateSwitchSelectIndex(
    RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
  newState..switchSelectIndex = action.payload;
  return newState;
}

RmbFragmentState _updateTopTabList(RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
  newState.topTabList = action.payload;
  return newState;
}
