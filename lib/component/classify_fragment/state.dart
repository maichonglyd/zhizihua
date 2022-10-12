import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/classify/state.dart';
import 'package:flutter_huoshu_app/component/classify/state.dart'
    as classify_new_fragment;
import 'package:flutter_huoshu_app/component/game/game_new_round_list/state.dart';
import 'package:flutter_huoshu_app/component/game/game_new_round_list/state.dart'
    as game_new_round_list;
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/utils/game_util.dart';

class ClassifyFragmentState implements Cloneable<ClassifyFragmentState> {
  ClassifyState classifyState;
  GameNewRoundListState firstGameNewRoundListState =
      game_new_round_list.initState(gameNewTourListTypeWeekend);
  GameNewRoundListState secondGameNewRoundListState =
      game_new_round_list.initState(gameNewTourListTypeComment);
  GameNewRoundListState thirdGameNewRoundListState =
      game_new_round_list.initState(gameNewTourListTypeOrder);

  TabController tabController;

  @override
  ClassifyFragmentState clone() {
    return ClassifyFragmentState()
      ..classifyState = classifyState
      ..firstGameNewRoundListState = firstGameNewRoundListState
      ..secondGameNewRoundListState = secondGameNewRoundListState
      ..thirdGameNewRoundListState = thirdGameNewRoundListState
      ..tabController = tabController;
  }
}

ClassifyFragmentState initState(String videoType) {
  HuoVideoManager.add(new HuoVideoViewExt(videoType));
  return ClassifyFragmentState()
    ..classifyState = classify_new_fragment.initState(videoType + "#1");
}

class ClassifyFragmentConnector
    extends ConnOp<ClassifyFragmentState, classify_new_fragment.ClassifyState> {
  @override
  void set(ClassifyFragmentState state,
      classify_new_fragment.ClassifyState subState) {
    state.classifyState = subState;
  }

  @override
  classify_new_fragment.ClassifyState get(ClassifyFragmentState state) {
    return state.classifyState;
  }
}

class FirstGameNewRoundListFragmentConnector
    extends ConnOp<ClassifyFragmentState, GameNewRoundListState> {
  @override
  void set(ClassifyFragmentState state, GameNewRoundListState subState) {
//    super.set(state, subState);
    state.firstGameNewRoundListState = subState;
  }

  @override
  GameNewRoundListState get(ClassifyFragmentState state) {
    return state.firstGameNewRoundListState;
  }
}

class SecondGameNewRoundListFragmentConnector
    extends ConnOp<ClassifyFragmentState, GameNewRoundListState> {
  @override
  void set(ClassifyFragmentState state, GameNewRoundListState subState) {
//    super.set(state, subState);
    state.secondGameNewRoundListState = subState;
  }

  @override
  GameNewRoundListState get(ClassifyFragmentState state) {
    return state.secondGameNewRoundListState;
  }
}

class ThirdGameNewRoundListFragmentConnector
    extends ConnOp<ClassifyFragmentState, GameNewRoundListState> {
  @override
  void set(ClassifyFragmentState state, GameNewRoundListState subState) {
//    super.set(state, subState);
    state.thirdGameNewRoundListState = subState;
  }

  @override
  GameNewRoundListState get(ClassifyFragmentState state) {
    return state.thirdGameNewRoundListState;
  }
}
