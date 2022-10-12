import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';

import 'package:flutter_huoshu_app/component/video/video_list/action.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';

Reducer<VideoState> buildReducer() {
  return asReducer(
    <Object, Reducer<VideoState>>{
      VideoAction.action: _onAction,
      VideoAction.updateData: _updateData,
      VideoAction.updateVolume: _updateVolume,
      VideoAction.switchVolume: _switchVolume,
      VideoAction.changeSliding: _changeSliding,
      VideoAction.sliderVal: _sliderVal,
      VideoAction.updateVideoVolume: _updateVideoVolume,
    },
  );
}

VideoState _onAction(VideoState state, Action action) {
  final VideoState newState = state.clone();
  return newState;
}

VideoState _switchVolume(VideoState state, Action action) {
  final VideoState newState = state.clone();
  String videoType =
      state.videoType + "#${state.swiperController.index}";
  if (newState.isShowVolume) {
    HuoVideoManager.pauseVolumeByType(videoType);
  } else {
    HuoVideoManager.playVolumeByType(videoType);
  }
  newState.isShowVolume = !newState.isShowVolume;
  return newState;
}

VideoState _updateVolume(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.volume = action.payload["volume"];
  return newState;
}

VideoState _changeSliding(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.isSliding = action.payload["isSliding"];
  return newState;
}

VideoState _sliderVal(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.sliderVal = action.payload["sliderVal"];
  return newState;
}

VideoState _updateData(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.news = action.payload;
  if (newState.news != null && newState.news.length > 0) {
    List<New> news = newState.news;
    for (int i = 0; i < news.length; i++) {
      HuoVideoManager.add(HuoVideoViewExt(state.videoType + "#${i}"));
    }
    //数据发生更新了
    HuoVideoManager.setViewActive(
        state.videoType + "#${state.swiperController.index}");
  }
  return newState;
}

VideoState _updateVideoVolume(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.isShowVolume = action.payload;
  return newState;
}
