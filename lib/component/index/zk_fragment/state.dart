import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner_state;
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as select_tab_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart'
    as index_top_tab;
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart'
    as index_row_game;
import 'package:flutter_huoshu_app/component/index/new_game_tip/state.dart';
import 'package:flutter_huoshu_app/component/index/new_game_tip/state.dart'
    as new_game_tip;
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart'
    as new_game_state;
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZKFragmentState implements Cloneable<ZKFragmentState> {
  TabController tabController;
  IndexSelectTabState indexSelectTabState;
  IndexBannerState indexBannerState;
  IndexRowGameState indexRowGameState;
  NewGameTipState newGameTipState;
  home_bean.Data homeData;
  List<BTGameItemState> gameStates;
  List<GameSpecialHeadState> gameSpecialStates;

  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;
  List<BTGameItemState> hotGameStates;
  List<BTGameItemState> newGameStates;

//  int type = TYPE_BT; // 用来区分页面
  int type = TYPE_HT; // 用来区分页面
  static final TYPE_HT = 0;
  static final TYPE_BT = 1;
  static final TYPE_ZK = 2;
  static final TYPE_H5 = 3;

  int switchData = 0; //表示人气热门/最新上架
  //新游预约
  NewGameReserveState newGameReserveState;

  ScrollController scrollController;
  bool showBackTop = false;
  String videoType;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int cardPage = 2;

  List<IndexTopTabBean> topTabList = [];

  @override
  ZKFragmentState clone() {
    return ZKFragmentState()
      ..tabController = tabController
      ..indexSelectTabState = indexSelectTabState
      ..indexBannerState = indexBannerState
      ..newGameReserveState = newGameReserveState
      ..indexRowGameState = indexRowGameState
      ..homeData = homeData
      ..gameStates = gameStates
      ..type = type
      ..videoType = videoType
      ..gameSpecialStates = gameSpecialStates
      ..refreshHelper = refreshHelper
      ..scrollController = scrollController
      ..switchData = switchData
      ..hotGameStates = hotGameStates
      ..newGameStates = newGameStates
      ..newGameTipState = newGameTipState
      ..showBackTop = showBackTop
      ..refreshHelperController = refreshHelperController
      ..refreshController = refreshController
      ..cardPage = cardPage
      ..topTabList = topTabList;
  }
}

ZKFragmentState initState(int initType, String videoType) {
  return ZKFragmentState()
    ..indexBannerState = index_banner_state.initState(videoType + "#0")
    ..indexRowGameState = index_row_game_state.initState()
    ..newGameTipState = new_game_tip.initState()
    ..newGameReserveState = new_game_state.initState()
    ..type = initType
    ..videoType = videoType
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController();
}
