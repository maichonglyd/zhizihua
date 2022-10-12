import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter_huoshu_app/component/deal/account_deal/deal_sell_list_fragment/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<MySellListState>
    extends ComponentState<MySellListState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<MySellListState> on Component<MySellListState> {
  @override
  SingleTickerProviderStfState<MySellListState> createState() =>
      SingleTickerProviderStfState<MySellListState>();
}

class MySellListPage extends Page<MySellListState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "MySellListPage";

  MySellListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MySellListState>(
              adapter: null,
              slots: <String, Dependent<MySellListState>>{
                "DealAllSellList":
                    DealAllSellListConnector() + DealSellListComponent(),
                "DealSellingList":
                    DealSellingListConnector() + DealSellListComponent(),
                "DealSoldList":
                    DealSoldListConnector() + DealSellListComponent(),
              }),
          middleware: <Middleware<MySellListState>>[],
        );
}
