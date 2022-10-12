import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/component/mine/integral_record/expend/component.dart';
import 'package:flutter_huoshu_app/component/mine/integral_record/income/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<IntegralRecordState>
    extends ComponentState<IntegralRecordState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<IntegralRecordState>
    on Component<IntegralRecordState> {
  @override
  SingleTickerProviderStfState<IntegralRecordState> createState() =>
      SingleTickerProviderStfState<IntegralRecordState>();
}

class IntegralRecordPage extends Page<IntegralRecordState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "IntegralRecordPage";
  IntegralRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntegralRecordState>(
              adapter: null,
              slots: <String, Dependent<IntegralRecordState>>{
                IntegralIncomeComponent.componentName:
                    IntegralIncomeConnector() + IntegralIncomeComponent(),
                IntegralExpendComponent.componentName:
                    IntegralExpendConnector() + IntegralExpendComponent(),
              }),
          middleware: <Middleware<IntegralRecordState>>[],
        );
}
