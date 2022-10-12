import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TurnGamePage extends Page<TurnGameState, Map<String, dynamic>> {
  static final String pageName = "TurnGamePage";

  TurnGamePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TurnGameState>(
              adapter: null, slots: <String, Dependent<TurnGameState>>{}),
          middleware: <Middleware<TurnGameState>>[],
        );
}
