import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

//TODO replace with your own action
enum IntegralShopAction {
  action,
  gotoRecord,
  onUpdateIntegral,
  updateIntegral,
  createController,
  gotoInvite,
  gotoExchangeRecord
}

class IntegralShopActionCreator {
  static Action onAction() {
    return const Action(IntegralShopAction.action);
  }

  static Action gotoRecord() {
    return const Action(IntegralShopAction.gotoRecord);
  }

  static Action gotoExchangeRecord() {
    return const Action(IntegralShopAction.gotoExchangeRecord);
  }

  static Action gotoInvite() {
    return const Action(IntegralShopAction.gotoInvite);
  }

  static Action onUpdateIntegral() {
    return Action(IntegralShopAction.onUpdateIntegral);
  }

  static Action updateIntegral(int integral) {
    return Action(IntegralShopAction.updateIntegral, payload: integral);
  }

  static Action onCreateController(TabController tabController) {
    return Action(IntegralShopAction.createController, payload: tabController);
  }
}
