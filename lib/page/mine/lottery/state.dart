import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_huoshu_app/model/user/lottery_draw.dart';
import 'package:flutter_huoshu_app/model/user/lottery_index.dart';
import 'dart:ui' as ui;

class LotteryState implements Cloneable<LotteryState> {
  LotteryIndexData lotteryIndexData;
  AnimationController animationController;
  CurvedAnimation curve;
  Animation<double> animation;
  double startAngle = 0;
  double endAngle = 1;
  bool isFirstComeIn = true;
  LotteryDrawData lotteryDrawData;

  @override
  LotteryState clone() {
    return LotteryState()
      ..animationController = animationController
      ..lotteryIndexData = lotteryIndexData
      ..curve = curve
      ..animation = animation
      ..startAngle = startAngle
      ..endAngle = endAngle
      ..isFirstComeIn = isFirstComeIn
      ..lotteryDrawData = lotteryDrawData;
  }
}

LotteryState initState(Map<String, dynamic> args) {
  return LotteryState();
}
