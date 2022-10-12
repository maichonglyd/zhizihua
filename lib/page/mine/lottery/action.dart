import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_huoshu_app/model/user/lottery_draw.dart';
import 'dart:ui' as ui;

import 'package:flutter_huoshu_app/model/user/lottery_index.dart';

//TODO replace with your own action
enum LotteryAction {
  action,
  loadLotteryData,
  updateLotteryData,
  createAnimationController,
  createAnimation,
  gotoTaskCenter,
  startLottery,
  updateLotteryInfo,
  showLotteryResult,
  showLotteryAddressDialog
}

class LotteryActionCreator {
  static Action onAction() {
    return const Action(LotteryAction.action);
  }

  static Action loadLotteryData() {
    return const Action(LotteryAction.loadLotteryData);
  }

  static Action showLotteryAddressDialog(String orderId) {
    return Action(LotteryAction.showLotteryAddressDialog, payload: orderId);
  }

  static Action updateLotteryData(LotteryIndexData data) {
    return Action(LotteryAction.updateLotteryData, payload: data);
  }

  static Action createAnimationController(AnimationController curvedAnimation) {
    return Action(LotteryAction.createAnimationController,
        payload: curvedAnimation);
  }

  static Action createAnimation() {
    print("动画action");
    return Action(LotteryAction.createAnimation);
  }

  static Action gotoTaskCenter() {
    return Action(LotteryAction.gotoTaskCenter);
  }

  static Action startLottery() {
    return Action(LotteryAction.startLottery);
  }

  static Action showLotteryResult() {
    return Action(LotteryAction.showLotteryResult);
  }

  static Action updateLotteryInfo(LotteryDrawData data) {
    return Action(LotteryAction.updateLotteryInfo, payload: data);
  }
}
