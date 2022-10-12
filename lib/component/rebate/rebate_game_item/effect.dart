import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_commit/page.dart';
import 'action.dart';
import 'state.dart';

Effect<RebateGameItemState> buildEffect() {
  return combineEffects(<Object, Effect<RebateGameItemState>>{
    RebateGameItemAction.action: _onAction,
    RebateGameItemAction.gotoRebateCommit: _gotoRebateCommit,
  });
}

void _onAction(Action action, Context<RebateGameItemState> ctx) {}

void _gotoRebateCommit(Action action, Context<RebateGameItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RebateCommitPage.pageName,
      arguments: ctx.state.rebateGame);
}
