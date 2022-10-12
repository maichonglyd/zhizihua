import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameStrategyMoneyPage
    extends Page<GameStrategyMoneyState, Map<String, dynamic>> {
  static final String pageName = "GameStrategyMoneyPage";
  static const int typeStrategyMoneyLevel = 0;
  static const int typeStrategyMoneyRecharge = 1;
  static const int typeStrategyMoneyShare = 2;

  GameStrategyMoneyPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameStrategyMoneyState>(
              adapter: null,
              slots: <String, Dependent<GameStrategyMoneyState>>{}),
          middleware: <Middleware<GameStrategyMoneyState>>[],
        );
}
