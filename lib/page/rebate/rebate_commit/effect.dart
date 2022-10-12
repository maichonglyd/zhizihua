import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action hide Action, Page;
import 'package:flutter_huoshu_app/api/rebate_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_roles.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/action.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_list/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/RebateSuccessDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<RebateCommitState> buildEffect() {
  return combineEffects(<Object, Effect<RebateCommitState>>{
    RebateCommitAction.showServiceDialog: _showServiceDialog,
    RebateCommitAction.showRoleDialog: _showServiceDialog,
    RebateCommitAction.selectDate: _selectDate,
    RebateCommitAction.commit: _commit,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<RebateCommitState> ctx) {}

void _dispose(Action action, Context<RebateCommitState> ctx) {
  ctx.state.blankToolBarModel.removeFocusListeners();
}

void _init(Action action, Context<RebateCommitState> ctx) {
  RebateService.getRebateRolesInfo(ctx.state.rebateGame.gameId).then((data) {
    ctx.dispatch(RebateCommitActionCreator.updateService(data.data.list));
  });

  ctx.state.blankToolBarModel.outSideCallback = () {
    ctx.dispatch(RebateCommitActionCreator.onAction());
  };
}

void _showServiceDialog(Action action, Context<RebateCommitState> ctx) {}

void _selectDate(Action action, Context<RebateCommitState> ctx) {
  RebateService.getAmount(ctx.state.rebateGame.gameId, action.payload)
      .then((data) {
    if (data["code"] == 200) {
      print(data['data']['real_amount']);
      ctx.dispatch(RebateCommitActionCreator.updateRealAmount(
          double.parse(data['data']['real_amount'].toString())));
    }
  });
  ctx.dispatch(RebateCommitActionCreator.updateDate(action.payload));
}

void _commit(Action action, Context<RebateCommitState> ctx) {
  String role = ctx.state.roleController.text;
  Server curServer = ctx.state.curServer;
  RoleList curRole = ctx.state.curRole;
  String mobile = ctx.state.mobileController.text;
  String remark = ctx.state.contentController.text;
  if (role.isEmpty) {
    showToast(getText(name: 'toastPleaseInputAccountId'));
    return;
  }
  if (curServer == null) {
    showToast(getText(name: 'toastPleaseSelectGameService'));
    return;
  }
  if (curRole == null) {
    showToast(getText(name: 'toastPleaseSelectGameRole'));
    return;
  }

  if (mobile.isEmpty) {
    showToast(getText(name: 'toastPleaseInputPhone'));
    return;
  }

  if (remark.isEmpty) {
    showToast(getText(name: 'textPleaseInputRemark'));
    return;
  }

  RebateService.addRebate(
          ctx.state.rebateGame.gameId,
          curRole.mgMemId,
          curServer.serverId,
          curServer.serverName,
          curRole.roleId,
          curRole.roleName,
          mobile,
          remark,
          ctx.state.time,
          ctx.state.time)
      .then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'textApplySuccessful'));
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return RebateSuccessDialog(() {
              Navigator.of(ctx.context).pop();
              ctx.broadcast(RebateApplyActionCreator.getData(1));
              AppUtil.gotoPageByName(
                  ctx.context, RebateRecordListPage.pageName);
            }, () {
              Navigator.of(ctx.context).pop();
              ctx.broadcast(RebateApplyActionCreator.getData(1));
            });
          });
    }
  });
}
