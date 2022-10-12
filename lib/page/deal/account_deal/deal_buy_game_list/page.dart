import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

//卖号时选择的游戏列表
class DealBuyGameListPage
    extends Page<DealBuyGameListState, Map<String, dynamic>> {
  static final String pageName = "DealBuyGameListPage";
  DealBuyGameListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealBuyGameListState>(
              adapter: null,
              slots: <String, Dependent<DealBuyGameListState>>{}),
          middleware: <Middleware<DealBuyGameListState>>[],
        );
}
