import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_played_item/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
as index_select_tab;

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<H5FragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<H5FragmentState>>{
      H5FragmentAction.action: _onAction,
      H5FragmentAction.createController: _createController,
      H5FragmentAction.updateHomeData: _updateHomeData,
      H5FragmentAction.switchData: _switchData,
      H5FragmentAction.updateCardGame: _updateCardGame,
    },
  );
}

H5FragmentState _switchData(H5FragmentState state, Action action) {
  final H5FragmentState newState = state.clone();
  newState.switchData = action.payload;
  return newState;
}

H5FragmentState _onAction(H5FragmentState state, Action action) {
  final H5FragmentState newState = state.clone();
  return newState;
}

H5FragmentState _createController(H5FragmentState state, Action action) {
  final H5FragmentState newState = state.clone();
  newState..tabController = action.payload;
  return newState;
}

H5FragmentState _updateHomeData(H5FragmentState state, Action action) {
  print("logcat update data");
  final H5FragmentState newState = state.clone();
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
    newState.indexBannerState = IndexBannerState()
      ..gameBannerItems = data.homeTopper.list
      ..hasVideo = hasVideo;
  }
  newState.indexRowGameState = IndexRowGameState()
    ..games = data.rmdGame.list
    ..showLine = true;

  if (data.newGame != null) {
    newState.gameStates = List<BTGameItemState>.from(data.newGame.list
        .map<BTGameItemState>((Game bean) => BTGameItemState()..game = bean)
        .toList());
  }

  for (GameSpecial gameSpecial in data.specialList.list) {
    if (gameSpecial.styleType == 9 && null != gameSpecial.gameListArray && gameSpecial.gameListArray.length > 0) {
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
  
  if (data.playedList != null && data.playedList.list.length > 0)
    newState.indexPlayedItemState = IndexPlayedItemState()
      ..playedList = data.playedList;

  return newState;
}

H5FragmentState _updateCardGame(
    H5FragmentState state, Action action) {
  final H5FragmentState newState = state.clone();
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