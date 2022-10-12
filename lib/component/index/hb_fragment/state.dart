import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_banner/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_list/state.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

class HbFragmentState implements Cloneable<HbFragmentState> {
  ScrollController scrollController;
  bool showBackTop = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  String videoType;
  GameRewardBannerState bannerState;
  GameRewardListState listState;
  home_bean.Data homeData;
  int cardPage = 2;
  int switchSelectIndex = 0; //表示人气热门/最新上架
  IndexSelectTabState indexSelectTabState;

  @override
  HbFragmentState clone() {
    return HbFragmentState()
      ..scrollController = scrollController
      ..showBackTop = showBackTop
      ..refreshController = refreshController
      ..videoType = videoType
      ..bannerState = bannerState
      ..listState = listState
      ..homeData = homeData
      ..cardPage = cardPage
      ..switchSelectIndex = switchSelectIndex
      ..indexSelectTabState = indexSelectTabState;
  }
}

HbFragmentState initState(String videoType) {
  return HbFragmentState()..videoType = videoType;
}
