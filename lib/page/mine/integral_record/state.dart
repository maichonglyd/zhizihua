import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/mine/integral_record/income/state.dart'
    as integral_income;
import 'package:flutter_huoshu_app/component/mine/integral_record/expend/state.dart'
    as integral_expend;

class IntegralRecordState implements Cloneable<IntegralRecordState> {
  TabController tabController;
  integral_income.IntegralIncomeState integralIncomeState;
  integral_expend.IntegralExpendState integralExpendState;

  @override
  IntegralRecordState clone() {
    return IntegralRecordState()
      ..tabController = tabController
      ..integralIncomeState = integralIncomeState
      ..integralExpendState = integralExpendState;
  }
}

IntegralRecordState initState(Map<String, dynamic> args) {
  return IntegralRecordState()
    ..integralIncomeState = integral_income.initState()
    ..integralExpendState = integral_expend.initState();
}

class IntegralIncomeConnector
    extends ConnOp<IntegralRecordState, integral_income.IntegralIncomeState> {
  @override
  void set(
      IntegralRecordState state, integral_income.IntegralIncomeState subState) {
//    super.set(state, subState);
    state.integralIncomeState = subState;
  }

  @override
  integral_income.IntegralIncomeState get(IntegralRecordState state) {
    return state.integralIncomeState;
  }
}

class IntegralExpendConnector
    extends ConnOp<IntegralRecordState, integral_expend.IntegralExpendState> {
  @override
  void set(
      IntegralRecordState state, integral_expend.IntegralExpendState subState) {
    state.integralExpendState = subState;
//    super.set(state, subState);
  }

  @override
  integral_expend.IntegralExpendState get(IntegralRecordState state) {
    return state.integralExpendState;
  }
}
