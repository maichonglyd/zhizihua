import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealHeadComponent extends Component<PropDealHeadState> {
  static final String componentName = "PropDealHeadComponent";
  PropDealHeadComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealHeadState>(
              adapter: null, slots: <String, Dependent<PropDealHeadState>>{}),
        );
}
