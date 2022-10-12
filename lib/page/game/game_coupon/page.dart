import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCouponPage extends Page<GameCouponState, Map<String, dynamic>> {
  static final String pageName = "GameCouponPage";

  GameCouponPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCouponState>(
              adapter: null, slots: <String, Dependent<GameCouponState>>{}),
          middleware: <Middleware<GameCouponState>>[],
        );
}
