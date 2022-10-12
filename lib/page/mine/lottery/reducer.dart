import 'dart:math';
import 'dart:typed_data';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'dart:ui' as ui;
import 'action.dart';
import 'state.dart';
import 'dart:async';
import 'package:flutter/services.dart' show ByteData, rootBundle;

Reducer<LotteryState> buildReducer() {
  return asReducer(
    <Object, Reducer<LotteryState>>{
      LotteryAction.action: _onAction,
      LotteryAction.createAnimationController: _createAnimationController,
      LotteryAction.updateLotteryData: _updateLotteryData,
      LotteryAction.updateLotteryInfo: _updateLotteryInfo,
    },
  );
}

LotteryState _onAction(LotteryState state, Action action) {
  final LotteryState newState = state.clone();
  return newState;
}

LotteryState _updateLotteryInfo(LotteryState state, Action action) {
  final LotteryState newState = state.clone();
  newState.lotteryDrawData = action.payload;
  return newState;
}

LotteryState _updateLotteryData(LotteryState state, Action action) {
  final LotteryState newState = state.clone();
  newState.lotteryIndexData = action.payload;
  return newState;
}

LotteryState _createAnimationController(LotteryState state, Action action) {
  final LotteryState newState = state.clone();
  newState.animationController = action.payload;
  CurvedAnimation curve =
      CurvedAnimation(parent: action.payload, curve: Curves.fastOutSlowIn);
  Animation<double> animation;

  if (state.lotteryDrawData != null) {
    double endAngle = 1 -
        (state.lotteryDrawData.data.listOrder /
                state.lotteryIndexData.data.award.list.length -
            1 / (state.lotteryIndexData.data.award.list.length * 2));
    print("角度:" + endAngle.toString());
    animation = Tween(begin: 0.0, end: 2 + endAngle).animate(curve);
  } else {
    animation = Tween(begin: 0.0, end: 2.0).animate(curve);
  }

  newState.animation = animation;
  if (!state.isFirstComeIn) {
    newState.animationController.forward();
  } else {
    newState.isFirstComeIn = false;
  }

  return newState;
}
