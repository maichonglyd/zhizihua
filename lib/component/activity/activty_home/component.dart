import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/activity/activity_list/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/gift/gift_list/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<ActivityHomeState>
    extends ComponentState<ActivityHomeState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<ActivityHomeState>
    on Component<ActivityHomeState> {
  @override
  SingleTickerProviderStfState<ActivityHomeState> createState() =>
      SingleTickerProviderStfState<ActivityHomeState>();
}

class ActivityHomeComponent extends Component<ActivityHomeState>
    with SingleTickerProviderMixin {
  static final String componentName = "ActivityHomeComponent";

  ActivityHomeComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ActivityHomeState>(
                adapter: null,
                slots: <String, Dependent<ActivityHomeState>>{
                  "giftlist_fragment":
                      GiftListFragmentConnector() + GiftListFragment(),
                  "activity_fragment":
                      ActivityFragmentConnector() + ActivityListComponent(),
                  "notice_fragment":
                      NoticeFragmentConnector() + ActivityListComponent(),
                  "strategy_fragment":
                      StrategyFragmentConnector() + ActivityListComponent(),
                }),
            wrapper: keepAliveWrapper);
}
