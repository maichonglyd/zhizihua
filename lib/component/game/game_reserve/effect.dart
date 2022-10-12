import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/GameReserveSuccessDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameReserveState> buildEffect() {
  return combineEffects(<Object, Effect<GameReserveState>>{
    GameReserveAction.action: _onAction,
    GameReserveAction.getData: _getData,
    GameReserveAction.subscribe: _subscribe,
    GameReserveAction.gotoGame: _gotoGame,
    GameReserveAction.cancel: _cancel,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameReserveState> ctx) {}

void _gotoGame(Action action, Context<GameReserveState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"isNewGame": true, "gameId": action.payload}).then((data) {
    ctx.dispatch(GameReserveActionCreator.getData(1));
  });
}

void _subscribe(Action action, Context<GameReserveState> ctx) {
  GameService.subscribe(action.payload).then((data) {
    if (data.code == 200) {
      showToast(getText(name: 'textAppointmentSuccessful'));
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return GameReserveSuccessDialog();
              },
            );
          });
      ctx.dispatch(GameReserveActionCreator.getData(1));
    } else {
      showToast(getText(name: 'textAppointmentFailed'));
    }
  });
}

void _cancel(Action action, Context<GameReserveState> ctx) {
  GameService.subscribe(action.payload).then((data) {
    if (data.code == 200) {
      ctx.dispatch(GameReserveActionCreator.getData(1));
    } else {
      showToast(getText(name: 'textAppointmentFailed'));
    }
  });
}

void _init(Action action, Context<GameReserveState> ctx) {
  ctx.dispatch(GameReserveActionCreator.getData(1));
}

void _getData(Action action, Context<GameReserveState> ctx) {
  int classify;
  if (ctx.state.isH5 == 5) {
    classify = 5;
  } else if (Platform.isAndroid) {
    classify = 3;
  } else {
    classify = 4;
  }
  GameService.getSubscribeGameList(2, action.payload,
          isBt: ctx.state.isBT, isRate: ctx.state.isZK, classify: classify)
      .then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
      return ctx.dispatch(GameReserveActionCreator.updateData(newData));
    }
  });
}
