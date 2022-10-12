import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<DealFragmentState>
    extends ComponentState<DealFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<DealFragmentState>
    on Component<DealFragmentState> {
  @override
  SingleTickerProviderStfState<DealFragmentState> createState() =>
      SingleTickerProviderStfState<DealFragmentState>();
}

class DealFragment extends Component<DealFragmentState>
    with SingleTickerProviderMixin {
  static final String componentName = "DealFragmentComponent";
  DealFragment()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DealFragmentState>(
                adapter: null,
                slots: <String, Dependent<DealFragmentState>>{
                  IndexDealFragment.componentName:
                      AccountDealFragmentConnector() + IndexDealFragment(),
                  PropDealFragment.componentName:
                      PropDealFragmentConnector() + PropDealFragment()
                }),
            wrapper: keepAliveWrapper);
}
