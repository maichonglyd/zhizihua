import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCoinRechargeRecordPage
    extends Page<GameCoinRechargeRecordState, Map<String, dynamic>> {
  static final pageName = "GameCoinRechargeRecordPage";
  GameCoinRechargeRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCoinRechargeRecordState>(
              adapter: null,
              slots: <String, Dependent<GameCoinRechargeRecordState>>{}),
          middleware: <Middleware<GameCoinRechargeRecordState>>[],
        );
}
