import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/component.dart'
    as account_deal_fragment;
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/state.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/component.dart'
    as prop_deal_fragment;
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/state.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';

class DealFragmentState implements Cloneable<DealFragmentState> {
  int index = 0;
  IndexDealFragmentState accountDealFragmentState;
  PropDealFragmentState propDealFragmentState;
  TabController tabController;
  String videoType;
  bool showBack = false;

  @override
  DealFragmentState clone() {
    return DealFragmentState()
      ..index = index
      ..showBack = showBack
      ..accountDealFragmentState = accountDealFragmentState
      ..propDealFragmentState = propDealFragmentState
      ..videoType = videoType
      ..tabController = tabController;
  }
}

DealFragmentState initState(String videoType, {bool showBack = false}) {
  HuoVideoManager.add(HuoVideoViewExt(videoType));
  return DealFragmentState()
    ..videoType = videoType
    ..showBack = showBack
    ..accountDealFragmentState = account_deal_fragment.initState()
    ..propDealFragmentState = prop_deal_fragment.initState();
}

class AccountDealFragmentConnector
    extends ConnOp<DealFragmentState, IndexDealFragmentState> {
  @override
  void set(DealFragmentState state, IndexDealFragmentState subState) {
//    super.set(state, subState);
    state.accountDealFragmentState = subState;
  }

  @override
  IndexDealFragmentState get(DealFragmentState state) {
    return state.accountDealFragmentState;
  }
}

class PropDealFragmentConnector
    extends ConnOp<DealFragmentState, PropDealFragmentState> {
  @override
  void set(DealFragmentState state, PropDealFragmentState subState) {
//    super.set(state, subState);
    state.propDealFragmentState = subState;
  }

  @override
  PropDealFragmentState get(DealFragmentState state) {
    return state.propDealFragmentState;
  }
}
