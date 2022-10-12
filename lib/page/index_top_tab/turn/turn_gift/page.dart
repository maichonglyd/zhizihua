import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TurnGiftPage extends Page<TurnGiftState, Map<String, dynamic>> {
  static final String pageName = "TurnGiftPage";

  TurnGiftPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TurnGiftState>(
              adapter: null, slots: <String, Dependent<TurnGiftState>>{}),
          middleware: <Middleware<TurnGiftState>>[],
        );
}
