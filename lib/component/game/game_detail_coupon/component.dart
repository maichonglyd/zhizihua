import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameDetailCouponComponent extends Component<GameDetailCouponState> {
  static final String componentName = "GameDetailCouponComponent";

  GameDetailCouponComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailCouponState>(
              adapter: null,
              slots: <String, Dependent<GameDetailCouponState>>{}),
        );
}
