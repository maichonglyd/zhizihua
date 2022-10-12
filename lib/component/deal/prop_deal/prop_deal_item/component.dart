import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealItemComponent extends Component<PropDealItemState> {
  static final String componentName = "PropDealItemComponent";
  PropDealItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealItemState>(
              adapter: null, slots: <String, Dependent<PropDealItemState>>{}),
        );
}
