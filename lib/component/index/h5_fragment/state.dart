import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart'
    as new_game_state;
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner_state;
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_played_item/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as select_tab_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class H5FragmentState implements Cloneable<H5FragmentState> {
  TabController tabController;
  IndexBannerState indexBannerState;
  IndexRowGameState indexRowGameState;
  IndexPlayedItemState indexPlayedItemState;
  IndexSelectTabState indexSelectTabState;

  //新游预约
  NewGameReserveState newGameReserveState;

  home_bean.Data homeData;
  List<BTGameItemState> gameStates;
  List<GameSpecialHeadState> gameSpecialStates;
  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;
  StreamSubscription subscription;

  int type = TYPE_HT; // 用来区分页面
  static final TYPE_BT = 1;
  static final TYPE_ZK = 2;
  static final TYPE_H5 = 3;
  static final TYPE_HT = 0;
  int switchData = 0; //表示人气热门/最新上架
  List<BTGameItemState> hotGameStates;
  List<BTGameItemState> newGameStates;
  String videoType;

  ScrollController scrollController;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int cardPage = 2;

  @override
  H5FragmentState clone() {
    return H5FragmentState()
      ..tabController = tabController
      ..indexBannerState = indexBannerState
      ..indexRowGameState = indexRowGameState
      ..indexSelectTabState = indexSelectTabState
      ..indexPlayedItemState = indexPlayedItemState
      ..newGameReserveState = newGameReserveState
      ..homeData = homeData
      ..gameStates = gameStates
      ..switchData = switchData
      ..type = type
      ..videoType = videoType
      ..hotGameStates = hotGameStates
      ..newGameStates = newGameStates
      ..scrollController = scrollController
      ..gameSpecialStates = gameSpecialStates
      ..refreshHelper = refreshHelper
      ..subscription = subscription
      ..refreshHelperController = refreshHelperController
      ..refreshController = refreshController
      ..cardPage = cardPage;
  }
}

H5FragmentState initState(int initType, String videoType) {
  return H5FragmentState()
    ..indexBannerState = index_banner_state.initState(videoType + "#0")
    ..indexRowGameState = index_row_game_state.initState()
    ..newGameReserveState = new_game_state.initState()
    ..type = initType
    ..videoType = videoType
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController();
}
