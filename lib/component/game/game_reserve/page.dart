import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameReservePage extends Page<GameReserveState, Map<String, dynamic>> {
  static final String pageName = "GameReservePage";
  GameReservePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameReserveState>(
              adapter: null, slots: <String, Dependent<GameReserveState>>{}),
          middleware: <Middleware<GameReserveState>>[],
        );
}
