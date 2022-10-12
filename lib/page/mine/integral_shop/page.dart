import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/component/mine/integral_shop_fragment/component.dart';
import 'effect.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<IntegralShopState>
    extends ComponentState<IntegralShopState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<IntegralShopState>
    on Component<IntegralShopState> {
  @override
  SingleTickerProviderStfState<IntegralShopState> createState() =>
      SingleTickerProviderStfState<IntegralShopState>();
}

class IntegralShopPage extends Page<IntegralShopState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "IntegralShopPage";
  IntegralShopPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IntegralShopState>(
//                adapter: NoneConn<shop_state.IntegralShopState>()+IntegralShopListAdapter(),
                adapter: null,
                slots: <String, Dependent<IntegralShopState>>{
                  'real_fragment':
                      RealFragmentConnector() + IntegralShopFragment(),
                  'virtual_fragment':
                      VirtualFragmentConnector() + IntegralShopFragment(),
                }),
            middleware: <Middleware<IntegralShopState>>[]);
}
