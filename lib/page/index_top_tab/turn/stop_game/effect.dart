import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/turn_game_service.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';
import 'package:flutter_huoshu_app/widget/dialog/GameNoRoleDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/TurnGameDialog.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Effect<StopGameState> buildEffect() {
  return combineEffects(<Object, Effect<StopGameState>>{
    Lifecycle.initState: _init,
    StopGameAction.action: _onAction,
    StopGameAction.showApplyDialog: _showApplyDialog,
    StopGameAction.getData: _getData,
    StopGameAction.submitApplication: _submitApplication,
  });
}

void _onAction(Action action, Context<StopGameState> ctx) {}

void _init(Action action, Context<StopGameState> ctx) {
  ctx.dispatch(StopGameActionCreator.getData(1));
}

void _showApplyDialog(Action action, Context<StopGameState> ctx) {
  TurnGameStopBean bean = action.payload;
  TurnGameService.getTurnGameRoleList(1, ctx.state.activityId, ctx.state.game.id).then((data) {
    if (200 == data.code) {
      if (null != data.data.list && data.data.list.length > 0) {
        showDialog<Null>(
            context: ctx.context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, state) {
                  return TurnGameDialog(
                    fromGame: bean,
                    toGame: ctx.state.game,
                    roleList: data.data.list,
                    confirmFun: (num roleId, formGame) {
                      ctx.dispatch(
                          StopGameActionCreator.submitApplication(roleId, formGame));
                    },
                  );
                },
              );
            });
      } else {
        GameService.getGameDetails(ctx.state.game.id).then((data) {
          if (200 == data.code) {
            if (null != data.data) {
              showDialog<Null>(
                  context: ctx.context, //BuildContext对象
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, state) {
                        return GameNoRoleDialog(
                          game: data.data,
                        );
                      },
                    );
                  });
            }
          }
        });
      }
    }
  });
}

void _getData(Action action, Context<StopGameState> ctx) {
  int page = action.payload;
  TurnGameService.getTurnGameStopList(page).then((data) {
    if (200 == data.code) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.list, page);
      ctx.dispatch(StopGameActionCreator.updateData(newData));
    }
  });
}

void _submitApplication(Action action, Context<StopGameState> ctx) {
  num roleId = action.payload['roleId'];
  TurnGameStopBean fromGame = action.payload['fromGame'];
  TurnGameService.applyTurnGameApply(ctx.state.activityId, fromGame.id, roleId)
      .then((data) {
    if (200 == data.code) {
      showToast('申请已提交，等待审核');
      ctx.dispatch(StopGameActionCreator.getData(1));
    }
  });
}
