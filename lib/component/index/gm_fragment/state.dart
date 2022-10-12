import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/game/gm_game_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/gm_game_fragment/state.dart'
    as gm_game_fragment;
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner;
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

class GmFragmentState implements Cloneable<GmFragmentState> {
  TabController tabController;
  GMGameFragmentState gameFragmentState = gm_game_fragment.initState(0);
  GMGameFragmentState helpFragmentState = gm_game_fragment.initState(1);
  IndexBannerState indexBannerState = index_banner.initState("1#5");
  home_bean.Data homeData;
  @override
  GmFragmentState clone() {
    return GmFragmentState()
      ..tabController = tabController
      ..gameFragmentState = gameFragmentState
      ..helpFragmentState = helpFragmentState
      ..indexBannerState = indexBannerState
      ..homeData = homeData;
  }
}

GmFragmentState initState() {
  return GmFragmentState();
}

class GMGameFragmentConnector
    extends ConnOp<GmFragmentState, gm_game_fragment.GMGameFragmentState> {
  @override
  void set(
      GmFragmentState state, gm_game_fragment.GMGameFragmentState subState) {
//    super.set(state, subState);
    state.gameFragmentState = subState;
  }

  @override
  gm_game_fragment.GMGameFragmentState get(GmFragmentState state) {
    return state.gameFragmentState;
  }
}

class GMHelpFragmentConnector
    extends ConnOp<GmFragmentState, gm_game_fragment.GMGameFragmentState> {
  @override
  void set(
      GmFragmentState state, gm_game_fragment.GMGameFragmentState subState) {
//    super.set(state, subState);
    state.helpFragmentState = subState;
  }

  @override
  gm_game_fragment.GMGameFragmentState get(GmFragmentState state) {
    return state.helpFragmentState;
  }
}

class IndexBannerConnector
    extends ConnOp<GmFragmentState, index_banner.IndexBannerState> {
  @override
  void set(GmFragmentState state, index_banner.IndexBannerState subState) {
//    super.set(state, subState);
    state.indexBannerState = subState;
  }

  @override
  index_banner.IndexBannerState get(GmFragmentState state) {
    return state.indexBannerState;
  }
}
