import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CouponItemComponent extends Component<CouponItemState> {
  static final String componentName = "CouponItemComponent";
  CouponItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CouponItemState>(
              adapter: null, slots: <String, Dependent<CouponItemState>>{}),
        );
}
