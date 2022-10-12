import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
export 'state.dart';

class DealItemTitleComponent extends Component<DealItemTitleState> {
  static final String componentName = "DealItemTitleComponent";
  DealItemTitleComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealItemTitleState>(
              adapter: null, slots: <String, Dependent<DealItemTitleState>>{}),
        );
}
