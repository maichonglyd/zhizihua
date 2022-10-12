import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealSelectGamePage
    extends Page<PropDealSelectGameState, Map<String, dynamic>> {
  static final String pageName = "PropDealSelectGamePage";
  PropDealSelectGamePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealSelectGameState>(
              adapter: null,
              slots: <String, Dependent<PropDealSelectGameState>>{}),
          middleware: <Middleware<PropDealSelectGameState>>[],
        );
}
