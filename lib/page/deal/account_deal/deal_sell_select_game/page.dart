import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DealSellSelectGamePage
    extends Page<DealSellSelectGameState, Map<String, dynamic>> {
  static final String pageName = "DealSellSelectGamePage";
  DealSellSelectGamePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealSellSelectGameState>(
              adapter: null,
              slots: <String, Dependent<DealSellSelectGameState>>{}),
          middleware: <Middleware<DealSellSelectGameState>>[],
        );
}
