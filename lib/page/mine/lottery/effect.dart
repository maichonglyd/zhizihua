import 'dart:typed_data';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryFailDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryRealGoodsAddressDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryRealGoodsDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotterySuccessDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';
import 'page.dart';
import 'dart:ui' as ui;

import 'dart:async';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart' show ByteData, rootBundle;

Effect<LotteryState> buildEffect() {
  return combineEffects(<Object, Effect<LotteryState>>{
    LotteryAction.action: _onAction,
    LotteryAction.loadLotteryData: _loadLotteryData,
    Lifecycle.initState: _initState,
    LotteryAction.createAnimation: _createAnimation,
    LotteryAction.gotoTaskCenter: _gotoTaskCenter,
    LotteryAction.startLottery: _startLottery,
    LotteryAction.showLotteryResult: _showLotteryResult,
    LotteryAction.showLotteryAddressDialog: _showLotteryAddressDialog,
  });
}

void _onAction(Action action, Context<LotteryState> ctx) {}

void _initState(Action action, Context<LotteryState> ctx) {
  ctx.dispatch(LotteryActionCreator.createAnimation());

  ctx.dispatch(LotteryActionCreator.loadLotteryData());
}

void _gotoTaskCenter(Action action, Context<LotteryState> ctx) {
  AppUtil.gotoPageByName(ctx.context, TaskCenterPage.pageName, arguments: null);
}

void _startLottery(Action action, Context<LotteryState> ctx) {
  UserService.getLotteryDraw().then((data) {
    if (data.code == 200) {
//      var newData = ctx.state.refreshHelperController.controllerRefresh(data.data.list, ctx.state.mems, action.payload);
      //  ctx.dispatch(LotteryActionCreator.updateLotteryData(data));
      //  ctx.dispatch(LotteryActionCreator.createAnimation());
//      showToast(data.data.listOrder.toString());
//      showToast(data.data.awardName.toString());
      ctx.dispatch(LotteryActionCreator.updateLotteryInfo(data));
      ctx.dispatch(LotteryActionCreator.createAnimation());
    }
  });
}

void _loadLotteryData(Action action, Context<LotteryState> ctx) {
  UserService.getLotteryIndex(1, 10).then((data) {
    if (data.code == 200) {
      ctx.dispatch(LotteryActionCreator.updateLotteryData(data));
    }
  });
}

void _showLotteryAddressDialog(Action action, Context<LotteryState> ctx) {
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return LotteryRealGoodsAddressDialog(action.payload);
          },
        );
      });
}

void _createAnimation(Action action, Context<LotteryState> ctx) {
  print("动画action2");
  // ctx.state.animationController.forward();
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  AnimationController controller = AnimationController(
      duration: Duration(milliseconds: (3 * 1000).toInt()),
      vsync: tickerProvider);

  //动画开始、结束、向前移动或向后移动时会调用StatusListener
  controller.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      //动画从 controller.forward() 正向执行 结束时会回调此方法

      if (ctx.state.lotteryDrawData != null) {
        ctx.dispatch(LotteryActionCreator.showLotteryResult());
        ctx.dispatch(LotteryActionCreator.loadLotteryData());
      }
      print("status is completed");
    } else if (status == AnimationStatus.dismissed) {
      //动画从 controller.reverse() 反向执行 结束时会回调此方法
      print("status is dismissed");
    } else if (status == AnimationStatus.forward) {
      print("status is forward");
      //执行 controller.forward() 会回调此状态
    } else if (status == AnimationStatus.reverse) {
      //执行 controller.reverse() 会回调此状态
      print("status is reverse");
    }
  });

  ctx.dispatch(LotteryActionCreator.createAnimationController(controller));
}

void _showLotteryResult(Action action, Context<LotteryState> ctx) {
  if (ctx.state.lotteryDrawData.data.hasAward != 2) {
    showDialog<Null>(
        context: ctx.context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return LotteryFailDialog();
            },
          );
        });
  } else {
    if (ctx.state.lotteryDrawData.data.isReal != 2) {
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return LotterySuccessDialog();
              },
            );
          });

//      if (ctx.state.lotteryDrawData.data.isReal != 2) {
//        showDialog<Null>(
//            context: ctx.context, //BuildContext对象
//            barrierDismissible: false,
//            builder: (BuildContext context) {
//              return StatefulBuilder(
//                builder: (context, state) {
//                  return LotteryRealGoodsDialog(ctx.state.lotteryDrawData);
//                },
//              );
//            });
    } else {
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return LotteryRealGoodsDialog(ctx.state.lotteryDrawData);
              },
            );
          });
    }
  }
}
