import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameSearchPage extends Page<GameSearchState, Map<String, dynamic>> {
  static final String pageName = "GameSearchPage";
  GameSearchPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameSearchState>(
              adapter: NoneConn<GameSearchState>() + GameListAdapter(),
              slots: <String, Dependent<GameSearchState>>{}),
          middleware: <Middleware<GameSearchState>>[],
        );
}
