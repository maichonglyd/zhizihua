import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/rebate_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_list/page.dart';
import 'action.dart';
import 'state.dart';

Effect<RebateApplyState> buildEffect() {
  return combineEffects(<Object, Effect<RebateApplyState>>{
    RebateApplyAction.action: _onAction,
    RebateApplyAction.getData: _getData,
    RebateApplyAction.gotoRebateRecord: _gotoRebateRecord,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<RebateApplyState> ctx) {}

void _getData(Action action, Context<RebateApplyState> ctx) {
  RebateService.getRebateList(action.payload, 10).then((data) {
    if (data.code == 200 && data.data != null) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.rebateGames, action.payload);
      ctx.dispatch(RebateApplyActionCreator.update(newData));
    } else {
      ctx.state.refreshHelperController.setEmpty();
      ctx.dispatch(RebateApplyActionCreator.update(List()));
    }
  });
}

void _init(Action action, Context<RebateApplyState> ctx) {
  ctx.dispatch(RebateApplyActionCreator.getData(1));
}

void _gotoRebateRecord(Action action, Context<RebateApplyState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RebateRecordListPage.pageName,
      arguments: null);
}
