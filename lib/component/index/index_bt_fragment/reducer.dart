import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';

import 'package:flutter_huoshu_app/component/index/gl_fragment/state.dart'
    as gl_fragment;
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart'
    as zk_fragment;
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart'
    as h5_fragment;
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart'
    as bt_fragment;
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart'
    as jp_fragment;
import 'package:flutter_huoshu_app/component/index/hb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/state.dart'
as hb_fragment;
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/state.dart'
as rmb_fragment;
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/state.dart'
as new_game_fragment;
import 'package:flutter_huoshu_app/component/video/screen_service.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexBtFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexBtFragmentState>>{
      IndexBtFragmentAction.createController: _createController,
      IndexBtFragmentAction.updateMsgCount: _updateMsgCount,
      IndexBtFragmentAction.updateShowMod: _updateShowMod,
      IndexBtFragmentAction.upDateOffset: _upDateOffset,
      IndexBtFragmentAction.updateHomeTabs: _updateHomeTabs,
    },
  );
}

IndexBtFragmentState _upDateOffset(IndexBtFragmentState state, Action action) {
//  Offset offset = action.payload;
  Offset offset = action.payload["offset"];
  Offset newOffset = Offset(offset.dx - (ScreenService.floatPointWidth / 2), offset.dy - (ScreenService.floatPointHeight / 2));
  if (newOffset.dx < 0) {
    newOffset = Offset(0, newOffset.dy);
  } else if (newOffset.dx > ScreenService.floatPointMaxX) {
    newOffset = Offset(ScreenService.floatPointMaxX, newOffset.dy);
  }

  if (newOffset.dy > ScreenService.floatPointMaxY) {
    newOffset = Offset(newOffset.dx, ScreenService.bottomBarOffsetY - ScreenService.floatPointHeight);
  }

  return state.clone()..offset = newOffset;
}

IndexBtFragmentState _updateHomeTabs(
    IndexBtFragmentState state, Action action) {
  HuoLog.d("_updateHomeTabs");
  state = state.clone();
  state.tabs = action.payload["homeTabs"];

  List<ItemBean> itemBeans = [];
  if (state.tabs != null && state.tabs.length > 0) {
    for (int i = 0; i < state.tabs.length; i++) {
      var value = state.tabs[i];
      String videoType = state.videoType + "#${i}";
      HuoVideoManager.add(HuoVideoViewExt(videoType));
      if (i == 0) {
        //保存第一个type
        LoginControl.saveTabType(value.type);
        LoginControl.saveIndex(i);
      }
      switch (value.type) {
        case BtFragmentComponent.typeName:
          var data = bt_fragment.initState(BtFragmentState.TYPE_BT, videoType);
          itemBeans.add(new ItemBean(BtFragmentComponent.componentName, data));
          break;
        case JpFragmentComponent.typeName:
//          var data = jp_fragment.initState(videoType);
          var data = jp_fragment.initState();
          itemBeans.add(new ItemBean(JpFragmentComponent.componentName, data));
          break;
        case H5FragmentComponent.typeName:
          var data = h5_fragment.initState(BtFragmentState.TYPE_H5, videoType);
          itemBeans.add(new ItemBean(H5FragmentComponent.componentName, data));
          break;
        case ZKFragmentComponent.typeName:
          var data = zk_fragment.initState(BtFragmentState.TYPE_ZK, videoType);
          itemBeans.add(new ItemBean(ZKFragmentComponent.componentName, data));
          break;
        case HbFragmentComponent.typeName:
          var data = hb_fragment.initState(videoType);
          itemBeans.add(new ItemBean(HbFragmentComponent.componentName, data));
          break;
        case RmbFragmentComponent.typeName:
          var data = rmb_fragment.initState(videoType);
          itemBeans.add(new ItemBean(RmbFragmentComponent.componentName, data));
          break;
        case NewGameFragmentComponent.typeName:
          var data = new_game_fragment.initState(videoType);
          itemBeans.add(new ItemBean(NewGameFragmentComponent.componentName, data));
          break;
        default:
          var data = gl_fragment.initState(value.type, videoType);
          itemBeans.add(new ItemBean(GlFragmentComponent.componentName, data));
          break;
      }
    }
    //默认第一个可见
    HuoVideoManager.setViewActive(
        state.videoType + "#${state.tabController.index}");
  }
  state.itemBeanList = itemBeans;
  state.index = action.payload["index"];
  return state;
}

IndexBtFragmentState _createController(
    IndexBtFragmentState state, Action action) {
  print("IndexBtFragmentReducer:_onAction");
  final IndexBtFragmentState newState = state.clone();
  newState..tabController = action.payload;
  return newState;
}

IndexBtFragmentState _updateMsgCount(
    IndexBtFragmentState state, Action action) {
  final IndexBtFragmentState newState = state.clone();
  newState.msgCount = action.payload;
  return newState;
}

IndexBtFragmentState _updateShowMod(IndexBtFragmentState state, Action action) {
  final IndexBtFragmentState newState = state.clone();
  newState.showMod = action.payload;
  return newState;
}
