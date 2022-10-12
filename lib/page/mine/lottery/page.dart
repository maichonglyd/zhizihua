import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<LotteryState>
    extends ComponentState<LotteryState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<LotteryState> on Component<LotteryState> {
  @override
  SingleTickerProviderStfState<LotteryState> createState() =>
      SingleTickerProviderStfState<LotteryState>();
}

class LotteryPage extends Page<LotteryState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "LotteryPage";
  LotteryPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LotteryState>(
                adapter: null, slots: <String, Dependent<LotteryState>>{}),
            wrapper: keepAliveWrapper);
}
