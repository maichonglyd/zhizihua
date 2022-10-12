import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/state.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/state.dart'
    as new_activity_state;
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner_state;
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart'
    as index_news_state;
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
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart'
    as new_game_state;
import 'package:flutter_huoshu_app/model/game/new_list.dart';

///手游
class HtFragmentState implements Cloneable<HtFragmentState> {
  TabController tabController;
  IndexSelectTabState indexSelectTabState;

  IndexBannerState indexBannerState;
  IndexRowGameState indexRowGameState;
  IndexNewsState indexNewsState;
  NewActivityState newActivityState;
  //新游预约
  NewGameReserveState newGameReserveState;

  home_bean.Data homeData;
  List<BTGameItemState> hotGameStates;
  List<BTGameItemState> newGameStates;
  List<GameSpecialHeadState> gameSpecialStates;

  int type = TYPE_HT; // 用来区分页面
  static final TYPE_BT = 1;
  static final TYPE_ZK = 2;
  static final TYPE_H5 = 3;
  static final TYPE_HT = 0;

  int switchData = 0; //表示人气热门/最新上架

  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;

  //滚动的ScrollController
  ScrollController scrollController;
  bool showBackTop = false;
  //测试视频用
  List<New> news = List();
  bool isShowVolume = true;
//  int index = 0;
  String videoType;
  bool hasVideo = false;

  @override
  HtFragmentState clone() {
    return HtFragmentState()
      ..tabController = tabController
      ..indexSelectTabState = indexSelectTabState
      ..indexBannerState = indexBannerState
      ..indexRowGameState = indexRowGameState
      ..indexNewsState = indexNewsState
      ..homeData = homeData
      ..hotGameStates = hotGameStates
      ..newGameStates = newGameStates
      ..newGameReserveState = newGameReserveState
      ..type = type
      ..videoType = videoType
      ..gameSpecialStates = gameSpecialStates
      ..switchData = switchData
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..scrollController = scrollController
      ..showBackTop = showBackTop
      ..news = news
      ..isShowVolume = isShowVolume
      ..hasVideo = hasVideo
      ..newActivityState = newActivityState;
  }
}

HtFragmentState initState(int initType, String videoType) {
  return HtFragmentState()
    ..indexBannerState = index_banner_state.initState(videoType + "#0")
    ..indexRowGameState = index_row_game_state.initState()
    ..indexNewsState = index_news_state.IndexNewsState()
    ..newActivityState = new_activity_state.initState()
    ..newGameReserveState = new_game_state.initState()
    ..type = initType
    ..videoType = videoType
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController();
}
