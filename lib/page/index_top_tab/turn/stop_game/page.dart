import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StopGamePage extends Page<StopGameState, Map<String, dynamic>> {
  static final String pageName = "StopGamePage";

  StopGamePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<StopGameState>(
              adapter: null, slots: <String, Dependent<StopGameState>>{}),
          middleware: <Middleware<StopGameState>>[],
        );
}
