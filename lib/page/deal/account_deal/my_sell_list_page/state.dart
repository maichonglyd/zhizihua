import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/deal_sell_list_fragment/state.dart'
    as deal_sell_list_state;
import 'package:flutter_huoshu_app/component/deal/account_deal/deal_sell_list_fragment/state.dart';

class MySellListState implements Cloneable<MySellListState> {
  TabController tabController;
  int index = 0;
  DealSellListState dealSellingListState; //正在出售
  DealSellListState dealSoldListState; //已经出售
  DealSellListState dealAllSellListState; //所有

  @override
  MySellListState clone() {
    return MySellListState()
      ..tabController = tabController
      ..index = index
      ..dealSellingListState = dealSellingListState
      ..dealSoldListState = dealSoldListState
      ..dealAllSellListState = dealAllSellListState;
  }
}

MySellListState initState(Map<String, dynamic> args) {
  int index = 0;
  if (args.containsKey("index")) {
    index = args['index'];
  }
  return MySellListState()
    ..dealAllSellListState = deal_sell_list_state.initState(0)
    ..dealSellingListState = deal_sell_list_state.initState(1)
    ..dealSoldListState = deal_sell_list_state.initState(2)
    ..index = index;
}

class DealSellingListConnector
    extends ConnOp<MySellListState, deal_sell_list_state.DealSellListState> {
  @override
  void set(
      MySellListState state, deal_sell_list_state.DealSellListState subState) {
//    super.set(state, subState);
    state.dealSellingListState = subState;
  }

  @override
  deal_sell_list_state.DealSellListState get(MySellListState state) {
    return state.dealSellingListState;
  }
}

class DealSoldListConnector
    extends ConnOp<MySellListState, deal_sell_list_state.DealSellListState> {
  @override
  void set(
      MySellListState state, deal_sell_list_state.DealSellListState subState) {
//    super.set(state, subState);
    state.dealSoldListState = subState;
  }

  @override
  deal_sell_list_state.DealSellListState get(MySellListState state) {
    return state.dealSoldListState;
  }
}

class DealAllSellListConnector
    extends ConnOp<MySellListState, deal_sell_list_state.DealSellListState> {
  @override
  void set(
      MySellListState state, deal_sell_list_state.DealSellListState subState) {
//    super.set(state, subState);
    state.dealAllSellListState = subState;
  }

  @override
  deal_sell_list_state.DealSellListState get(MySellListState state) {
    return state.dealAllSellListState;
  }
}
