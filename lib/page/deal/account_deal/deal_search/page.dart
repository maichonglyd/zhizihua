import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DealSearchPage extends Page<DealSearchState, Map<String, dynamic>> {
  static final String pageName = "DealSearchPage";
  DealSearchPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealSearchState>(
              adapter: NoneConn<DealSearchState>() + GameListAdapter(),
              slots: <String, Dependent<DealSearchState>>{}),
          middleware: <Middleware<DealSearchState>>[],
        );
}
