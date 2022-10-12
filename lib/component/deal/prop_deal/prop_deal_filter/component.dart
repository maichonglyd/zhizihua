import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealFilterComponent extends Component<PropDealFilterState> {
  static final String componentName = "PropDealFilterComponent";
  PropDealFilterComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealFilterState>(
              adapter: null, slots: <String, Dependent<PropDealFilterState>>{}),
        );
}
