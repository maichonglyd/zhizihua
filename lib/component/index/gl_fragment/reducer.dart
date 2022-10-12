import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/redux_connector/private_action_mixin.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

Reducer<GlFragmentState> buildReducer() {
  return asPrivateReducer(
    <Object, Reducer<GlFragmentState>>{
      GlFragmentAction.update: _update,
      GlFragmentAction.updateType: _updateType,
      GlFragmentAction.createPlayController: _createPlayController,
      GlFragmentAction.createController: _createController,
      GlFragmentAction.updateVolume: _updateVolume,
      GlFragmentAction.changeVideoState: _changeVideoState,
      GlFragmentAction.updatePlaying: _updatePlaying,
      GlFragmentAction.updateHomeData: _updateHomeData,
      GlFragmentAction.updateTopTabList: _updateTopTabList,
    },
  );
}

GlFragmentState _updateHomeData(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  home_bean.Data data = action.payload;
  newState.homeData = data;
  if (data.homeTopper != null) {
    bool hasVideo = false;
    if (data.homeTopper.list != null) {
      for (GameBannerItem item in data.homeTopper.list) {
        if (item.typeName == "game" && item.url.isNotEmpty) {
          hasVideo = true;
          break;
        } else {
          continue;
        }
      }
    }
    newState.indexBannerState = IndexBannerState()
      ..gameBannerItems = data.homeTopper.list
      ..hasVideo = hasVideo;
    print("homeTopper${data.homeTopper.list}");
  }

  return newState;
}

GlFragmentState _updatePlaying(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.isPlaying = action.payload;
  return newState;
}

GlFragmentState _changeVideoState(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.isPlaying = !newState.isPlaying;
  return newState;
}

GlFragmentState _updateVolume(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.hasVolume = action.payload;
  return newState;
}

GlFragmentState _createController(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.scrollController = action.payload['scrollController'];
  return newState;
}

GlFragmentState _createPlayController(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.videoPlayerController = action.payload;
  return newState;
}

GlFragmentState _update(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.games = action.payload;
  return newState;
}

GlFragmentState _updateType(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.type = action.payload;
  return newState;
}

GlFragmentState _updateTopTabList(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  newState.topTabList = action.payload;
  return newState;
}
