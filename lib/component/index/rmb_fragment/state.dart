import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner_state;
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game_state;

class RmbFragmentState implements Cloneable<RmbFragmentState> {
  ScrollController scrollController;
  bool showBackTop = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  String videoType;
  home_bean.Data homeData;
  bool isShowVolume = true;
  IndexBannerState indexBannerState;
  IndexRowGameState indexRowGameState;
  int cardPage = 2;
  int switchSelectIndex = 0; //表示人气热门/最新上架
  IndexSelectTabState indexSelectTabState;

  List<IndexTopTabBean> topTabList = [];

  @override
  RmbFragmentState clone() {
    return RmbFragmentState()
      ..scrollController = scrollController
      ..showBackTop = showBackTop
      ..refreshController = refreshController
      ..videoType = videoType
      ..homeData = homeData
      ..isShowVolume = isShowVolume
      ..indexBannerState = indexBannerState
      ..indexRowGameState = indexRowGameState
      ..cardPage = cardPage
      ..switchSelectIndex = switchSelectIndex
      ..indexSelectTabState = indexSelectTabState
      ..topTabList = topTabList;
  }
}

RmbFragmentState initState(String videoType) {
  return RmbFragmentState()
    ..videoType = videoType
    ..indexBannerState = index_banner_state.initState(videoType + "#0")
    ..indexRowGameState = index_row_game_state.initState();
}
