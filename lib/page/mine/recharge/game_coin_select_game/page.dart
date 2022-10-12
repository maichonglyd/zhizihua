import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCoinSelectGamePage
    extends Page<GameCoinSelectGameState, Map<String, dynamic>> {
  static final String pageName = "GameCoinSelectGamePage";
  GameCoinSelectGamePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCoinSelectGameState>(
              adapter: null,
              slots: <String, Dependent<GameCoinSelectGameState>>{}),
          middleware: <Middleware<GameCoinSelectGameState>>[],
        );
}
