import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameSpecialPagePage
    extends Page<GameSpecialPageState, Map<String, dynamic>> {
  static final String pageName = "GameSpecialPagePage";
  GameSpecialPagePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameSpecialPageState>(
              adapter: NoneConn<GameSpecialPageState>() + GameListAdapter(),
              slots: <String, Dependent<GameSpecialPageState>>{}),
          middleware: <Middleware<GameSpecialPageState>>[],
        );
}
