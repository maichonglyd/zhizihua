import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/deal/deal_fragment/state.dart';
import 'package:flutter_huoshu_app/component/deal/deal_fragment/state.dart'
    as deal_fragment;

class DealState implements Cloneable<DealState> {
  DealFragmentState dealFragmentState;

  @override
  DealState clone() {
    return DealState()..dealFragmentState = dealFragmentState;
  }
}

DealState initState(Map<String, dynamic> args) {
  return DealState()
    ..dealFragmentState =
        deal_fragment.initState(args["index"] == null ? 0 : args["index"], showBack: true);
//    ..dealFragmentState = deal_fragment.initState(1);
}

class DealFragmentConnector extends ConnOp<DealState, DealFragmentState> {
  @override
  void set(DealState state, DealFragmentState subState) {
    state.dealFragmentState = subState;
  }

  @override
  DealFragmentState get(DealState state) {
    return state.dealFragmentState;
  }
}
