import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_payback/page.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountRecycleRecordState> buildEffect() {
  return combineEffects(<Object, Effect<AccountRecycleRecordState>>{
    AccountRecycleRecordAction.action: _onAction,
    AccountRecycleRecordAction.payback: _payback,
    AccountRecycleRecordAction.pay: _pay,
    AccountRecycleRecordAction.getOrders: _getOrders,
    AccountRecycleRecordAction.getExplain: _getExplain,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<AccountRecycleRecordState> ctx) {}

void _getExplain(Action action, Context<AccountRecycleRecordState> ctx) {
  UserService.getRecycleExplain().then((data) {
    if (data.code == 200) {
      ctx.dispatch(AccountRecycleRecordActionCreator.updateExplain(data));
    }
  });
}

void _getOrders(Action action, Context<AccountRecycleRecordState> ctx) {
  UserService.getRecycleOrderList(action.payload).then((data) {
    if (data.code == 200) {
      data.data.list = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list,
          ctx.state.recycleList != null
              ? ctx.state.recycleList.data.list
              : List<RecycleMg>(),
          action.payload);
      ctx.dispatch(AccountRecycleRecordActionCreator.update(data));
    }
  });
}

void _pay(Action action, Context<AccountRecycleRecordState> ctx) {}

void _payback(Action action, Context<AccountRecycleRecordState> ctx) {
  UserService.recycleProOrder(action.payload).then((data) {
    if (data.code == 200) {
      showDialog(
          context: ctx.context,
          builder: (context) {
            return AccountRecyclePaybackPage().buildPage(data);
          },
          barrierDismissible: false);
    }
//  AppUtil.gotoH5Web(ctx.context, AppConfig.baseUrl+"app/recycle/payback?recycle_id=${action.payload}",title:"小号回收");
  });
}

void _init(Action action, Context<AccountRecycleRecordState> ctx) {
  ctx.dispatch(AccountRecycleRecordActionCreator.getExplain());
  ctx.dispatch(AccountRecycleRecordActionCreator.getOrders(1));
}
