import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/mine/integral_shop_fragment/state.dart';
import 'package:flutter_huoshu_app/component/mine/integral_shop_fragment/state.dart'
    as integral_fragment;
import 'package:flutter_huoshu_app/component/mine/integral_shop_fragment/state.dart'
    as virtual_integral_fragment;
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

class IntegralShopState implements Cloneable<IntegralShopState> {
  IntegralShopFragmentState realFragmentState = integral_fragment.initState(2);
  IntegralShopFragmentState virtualFragmentState =
      virtual_integral_fragment.initState(1);
  List<Goods> goodsList;
  num integral = 0;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  TabController controller;

  @override
  IntegralShopState clone() {
    return IntegralShopState()
      ..goodsList = goodsList
      ..integral = integral
      ..controller = controller
      ..refreshHelper = refreshHelper
      ..realFragmentState = realFragmentState
      ..virtualFragmentState = virtualFragmentState
      ..refreshHelperController = refreshHelperController;
  }
}

IntegralShopState initState(Map<String, dynamic> args) {
  return IntegralShopState()..goodsList = List();
}

class RealFragmentConnector extends ConnOp<IntegralShopState,
    integral_fragment.IntegralShopFragmentState> {
  @override
  void set(IntegralShopState state,
      integral_fragment.IntegralShopFragmentState subState) {
//    super.set(state, subState);
    state.realFragmentState = subState;
  }

  @override
  integral_fragment.IntegralShopFragmentState get(IntegralShopState state) {
    return state.realFragmentState;
  }
}

class VirtualFragmentConnector extends ConnOp<IntegralShopState,
    virtual_integral_fragment.IntegralShopFragmentState> {
  @override
  void set(IntegralShopState state,
      virtual_integral_fragment.IntegralShopFragmentState subState) {
//    super.set(state, subState);
    state.virtualFragmentState = subState;
  }

  @override
  virtual_integral_fragment.IntegralShopFragmentState get(
      IntegralShopState state) {
    return state.virtualFragmentState;
  }
}
