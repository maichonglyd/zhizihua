import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IntegralShopItemComponent extends Component<IntegralShopItemState> {
  static final String componentName = "IntegralShopItemComponent";
  IntegralShopItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntegralShopItemState>(
              adapter: null,
              slots: <String, Dependent<IntegralShopItemState>>{}),
        );
}
