import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCoinRechargePage
    extends Page<GameCoinRechargeState, Map<String, dynamic>> {
  static final String pageName = "GameCoinRechargePage";

  GameCoinRechargePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCoinRechargeState>(
              adapter: null,
              slots: <String, Dependent<GameCoinRechargeState>>{}),
          middleware: <Middleware<GameCoinRechargeState>>[],
        );
}
