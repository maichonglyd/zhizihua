import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/component/classify/state.dart';
import 'package:flutter_huoshu_app/component/classify_fragment/state.dart';
import 'package:flutter_huoshu_app/component/deal/deal_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/game_classify/state.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/index_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/state.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart'
    as videostate;
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/coupon/reward_bean_list.dart';
import 'package:flutter_huoshu_app/model/home_tab_vo.dart';
import 'package:flutter_huoshu_app/component/index/index_fragment/state.dart'
    as index_fragment;
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/state.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/state.dart'
    as mine_fragment;
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/state.dart'
    as bt_fragment;
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/state.dart'
    as kf_fragment;
import 'package:flutter_huoshu_app/component/deal/deal_fragment/state.dart'
    as deal_fragment;
import 'package:flutter_huoshu_app/component/game/game_classify/state.dart'
    as classify_fragment;
import 'package:flutter_huoshu_app/component/classify_fragment/state.dart'
    as classify_new_fragment;
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';

class HomeState extends BaseState with GlobalBaseState<HomeState> {
  int splashTime = 4;
  TabController controller;
  List<HomeTabVO> homeTabs = [];
  int index = 0;
  IndexFragmentState indexFragmentState;
  MineFragmentState mineFragmentState;
  IndexBtFragmentState indexBtFragmentState;

  // DealFragmentState indexDealFragmentState = deal_fragment.initState();
  DealFragmentState indexDealFragmentState;
  GameClassifyState gameClassifyState = classify_fragment.initState();
  ClassifyFragmentState classifyState;

  VideoState videoState;
  Splash splash;
  UpInfo upInfo;
  bool showTab = false;
  bool hasAgreeProtocol = false;

  @override
  HomeState clone() {
    return HomeState()
      ..copyGlobalFrom(this)
      ..controller = controller
      ..homeTabs = initHomeTabs()
      ..index = index
      ..indexFragmentState = indexFragmentState
      ..indexBtFragmentState = indexBtFragmentState
      ..mineFragmentState = mineFragmentState
      ..indexDealFragmentState = indexDealFragmentState
      ..gameClassifyState = gameClassifyState
      ..classifyState = classifyState
      ..splash = splash
      ..upInfo = upInfo
      ..splashTime = splashTime
      ..showTab = showTab
      ..loadStatus = loadStatus
      ..videoState = videoState
      ..hasAgreeProtocol = hasAgreeProtocol;
  }
}

List<HomeTabVO> initHomeTabs() {
  final List<HomeTabVO> homeTabs = [
    new HomeTabVO(getText(name: 'textHome'), "images/tab_ic_home_normal.png",
        "images/tab_ic_home_select.png"),
    new HomeTabVO(
        getText(name: 'textClassify'),
        "images/tab_ic_gamecalling_normal.png",
        "images/tab_ic_gamecalling_select.png"),
    new HomeTabVO(getText(name: 'textVideo'), "images/tab_ic_video_normal.png",
        "images/tab_ic_video_select.png"),
//    new HomeTabVO(S.current.tab_service, "images/icon_n_kaifu_normal.png",
//        "images/icon_n_kaifu_tabbar_selected.png"),
    new HomeTabVO(getText(name: 'textDeal'), "images/tab_ic_jiaoyi_normal.png",
        "images/tab_ic_jiaoyi_select.png"),
    new HomeTabVO(getText(name: 'textMine'), "images/tab_ic_mine_normal.png",
        "images/tab_ic_mine_select.png"),
  ];
  return homeTabs;
}

HomeState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  HomeState state = HomeState()..homeTabs = initHomeTabs();
  state.mineFragmentState =
      mine_fragment.initState(HuoVideoManager.type_home + "#4");
  // state.mineFragmentState =
  //     mine_fragment.initState();
  state.indexBtFragmentState =
      bt_fragment.initState(HuoVideoManager.type_home + "#0");
  state.indexDealFragmentState =
      deal_fragment.initState(HuoVideoManager.type_home + "#3");
  state.classifyState =
      classify_new_fragment.initState(HuoVideoManager.type_home + "#1");
  state.videoState = videostate.initState(HuoVideoManager.type_home + "#2");
  HuoVideoManager.setViewActive(HuoVideoManager.type_home + "#0");
  return state;
}

class MineFunListConnector
    extends ConnOp<HomeState, index_fragment.IndexFragmentState> {
  @override
  void set(HomeState state, index_fragment.IndexFragmentState subState) {
    super.set(state, subState);
  }

  @override
  index_fragment.IndexFragmentState get(HomeState state) {
    return index_fragment.initState(null);
  }
}

class MineFragmentConnector
    extends ConnOp<HomeState, mine_fragment.MineFragmentState> {
  @override
  void set(HomeState state, mine_fragment.MineFragmentState subState) {
//    super.set(state, subState);
    state.mineFragmentState = subState;
  }

  @override
  mine_fragment.MineFragmentState get(HomeState state) {
    return state.mineFragmentState;
  }
}

class BtFragmentConnector
    extends ConnOp<HomeState, bt_fragment.IndexBtFragmentState> {
  @override
  void set(HomeState state, bt_fragment.IndexBtFragmentState subState) {
//    super.set(state, subState);
    state.indexBtFragmentState = subState;
  }

  @override
  bt_fragment.IndexBtFragmentState get(HomeState state) {
    return state.indexBtFragmentState;
  }
}

//游戏分类
class ClassifyFragmentConnector
    extends ConnOp<HomeState, classify_new_fragment.ClassifyFragmentState> {
  @override
  void set(HomeState state, classify_new_fragment.ClassifyFragmentState subState) {
    state.classifyState = subState;
  }

  @override
  classify_new_fragment.ClassifyFragmentState get(HomeState state) {
    return state.classifyState;
  }
}

class GameClassifyFragmentConnector
    extends ConnOp<HomeState, classify_fragment.GameClassifyState> {
  @override
  void set(HomeState state, classify_fragment.GameClassifyState subState) {
    state.gameClassifyState = subState;
  }

  @override
  classify_fragment.GameClassifyState get(HomeState state) {
    return state.gameClassifyState;
  }
}

class DealFragmentConnector
    extends ConnOp<HomeState, deal_fragment.DealFragmentState> {
  @override
  void set(HomeState state, deal_fragment.DealFragmentState subState) {
//    super.set(state, subState);
    state.indexDealFragmentState = subState;
  }

  @override
  deal_fragment.DealFragmentState get(HomeState state) {
    return state.indexDealFragmentState;
  }
}

class VideoFragmentConnector extends ConnOp<HomeState, videostate.VideoState> {
  @override
  void set(HomeState state, videostate.VideoState subState) {
//    super.set(state, subState);
    state.videoState = subState;
  }

  @override
  videostate.VideoState get(HomeState state) {
    return state.videoState;
  }
}
