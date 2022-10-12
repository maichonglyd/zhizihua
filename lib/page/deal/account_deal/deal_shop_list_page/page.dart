import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DealShopListPage extends Page<DealShopListPageState, PlayedGame> {
  static final String pageName = "DealShopListPagePage";
  DealShopListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealShopListPageState>(
              adapter: NoneConn<DealShopListPageState>() + DealListAdapter(),
              slots: <String, Dependent<DealShopListPageState>>{}),
          middleware: <Middleware<DealShopListPageState>>[],
        );
}
