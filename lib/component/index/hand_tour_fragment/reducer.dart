import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<HtFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<HtFragmentState>>{
      HtFragmentAction.action: _onAction,
      HtFragmentAction.createController: _createController,
      HtFragmentAction.updateHomeData: _updateHomeData,
      HtFragmentAction.switchData: _switchData,
      HtFragmentAction.createScrollController: _createScrollController,
    },
  );
}

HtFragmentState _createScrollController(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
  newState..scrollController = action.payload;
  return newState;
}

HtFragmentState _onAction(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
  return newState;
}

HtFragmentState _switchData(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
  newState.switchData = action.payload;
  return newState;
}

HtFragmentState _createController(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
  newState..tabController = action.payload;
  return newState;
}

HtFragmentState _updateHomeData(HtFragmentState state, Action action) {
  final HtFragmentState newState = state.clone();
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
    newState.indexBannerState = IndexBannerState()
      ..gameBannerItems = data.homeTopper.list
      ..news = newState.news
      ..isShowVolume = newState.isShowVolume
      ..hasVideo = hasVideo;
  }

  if (data.appIndexTextList != null && data.appIndexTextList.list.length > 0) {
    List<AppIndexTextListData> homeNotice = data.appIndexTextList.list;
//    homeNotice.clear();
//    homeNotice.addAll(data.appIndexTextList.list);
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

  //初始化新游预约数据
  if (data.subscribeGame != null && data.subscribeGame.list.length > 0) {
    newState.newGameReserveState = NewGameReserveState()
      ..games = data.subscribeGame.list;
  }

  newState.indexRowGameState = IndexRowGameState()
    ..games = data.rmdGame.list
    ..showLine = false;

  int i = 0;
  for (GameSpecial gameSpecial in data.specialList.list) {
    if (gameSpecial.styleType == 9) {
      //最新上架/人气热门
      int j = 0;
      print("i$i");
      if (gameSpecial.gameListArray != null &&
          gameSpecial.gameListArray.length > 0) {
        for (GameListBean game in gameSpecial.gameListArray) {
          List<Game> games = List();
          games.clear();
          if (game.gameList != null && game.gameList.length > 0) {
            games.addAll(game.gameList);
            if (j == 0) {
              //人气热门
              newState.hotGameStates = List<BTGameItemState>.from(games
                  .map<BTGameItemState>(
                      (Game bean) => BTGameItemState()..game = bean)
                  .toList());
            } else {
              newState.newGameStates = List<BTGameItemState>.from(games
                  .map<BTGameItemState>(
                      (Game bean) => BTGameItemState()..game = bean)
                  .toList());
            }
          }
          j++;
        }
      } else {
        break;
      }
    } else {
      continue;
    }
    i++;
  }

//  if (data.hotGame != null) {
//    newState.hotGameStates = List<BTGameItemState>.from(data.hotGame.list
//        .map<BTGameItemState>((Game bean) => BTGameItemState()..game = bean)
//        .toList());
//  }
//
//  if (data.newGame != null) {
//    newState.newGameStates = List<BTGameItemState>.from(data.newGame.list
//        .map<BTGameItemState>((Game bean) => BTGameItemState()..game = bean)
//        .toList());
//  }
  newState.gameSpecialStates = List<GameSpecialHeadState>.from(data
      .specialList.list
      .map<GameSpecialHeadState>(
          (GameSpecial bean) => GameSpecialHeadState()..gameSpecial = bean)
      .toList());
  return newState;
}
