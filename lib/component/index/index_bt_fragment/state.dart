import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart'
    as bt_fragment;
import 'package:flutter_huoshu_app/component/index/hand_tour_fragment/component.dart'
    as ht_fragment;
import 'package:flutter_huoshu_app/component/index/gm_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/gm_fragment/state.dart'
    as gm_fragment;
import 'package:flutter_huoshu_app/component/index/h5_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/hand_tour_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart'
    as zk_fragment;

import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart'
    as h5_fragment;

import 'package:flutter_huoshu_app/component/index/bt_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart'
    as jp_fragment;
import 'package:flutter_huoshu_app/component/index/jp_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/state.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/component/video/screen_service.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

class IndexBtFragmentState implements Cloneable<IndexBtFragmentState> {
  TabController tabController;

//  HtFragmentState htFragmentState =
//      ht_fragment.initState(HtFragmentState.TYPE_HT);
//  BtFragmentState btFragmentState =
//      bt_fragment.initState(BtFragmentState.TYPE_BT);
//  ZKFragmentState zkFragmentState =
//      zk_fragment.initState(BtFragmentState.TYPE_ZK);
//  H5FragmentState h5FragmentState =
//      h5_fragment.initState(BtFragmentState.TYPE_H5);
//  JpFragmentState jpFragmentState = jp_fragment.initState();
//  GmFragmentState gmFragmentState = gm_fragment.initState();
  int msgCount = 0;
  List<String> showMod;

  //滚动的ScrollController
  ScrollController scrollController = ScrollController();

  List<Mod> tabs = [];
  List<ItemBean> itemBeanList = [];
  int index;
  String type;
  String videoType;

  Offset offset = ScreenService.floatPointOffset;

  @override
  IndexBtFragmentState clone() {
    return IndexBtFragmentState()
      ..tabController = tabController
      ..scrollController = scrollController
      ..msgCount = msgCount
      ..tabs = tabs
      ..itemBeanList = itemBeanList
      ..videoType = videoType
      ..offset = offset
      ..showMod = showMod;
  }
}

IndexBtFragmentState initState(String videoType) {
  HuoVideoManager.add(HuoVideoViewExt(videoType));
  return IndexBtFragmentState()..videoType = videoType;
}
