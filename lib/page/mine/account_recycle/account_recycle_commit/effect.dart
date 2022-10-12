import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_success/page.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountRecycleCommitState> buildEffect() {
  return combineEffects(<Object, Effect<AccountRecycleCommitState>>{
    AccountRecycleCommitAction.action: _onAction,
    AccountRecycleCommitAction.commit: _commit,
    AccountRecycleCommitAction.close: _close,
  });
}

void _onAction(Action action, Context<AccountRecycleCommitState> ctx) {}
void _close(Action action, Context<AccountRecycleCommitState> ctx) {
  Navigator.pop(ctx.context);
}

void _commit(Action action, Context<AccountRecycleCommitState> ctx) {
  //判断手机
  //弹窗
  UserService.addRecycle(action.payload).then((data) {
    if (data.code == 200) {
      showDialog(
              context: ctx.context,
              builder: (context) {
                return AccountRecycleSuccessPage()
                    .buildPage(ctx.state.recycleMg.amount);
              },
              barrierDismissible: false)
          .then((data) {
        Navigator.pop(ctx.context);
      });
    }
  });
}
