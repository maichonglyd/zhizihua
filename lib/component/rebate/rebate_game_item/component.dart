import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RebateGameItemComponent extends Component<RebateGameItemState> {
  static final String componentName = "RebateGameItemComponent";
  RebateGameItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RebateGameItemState>(
              adapter: null, slots: <String, Dependent<RebateGameItemState>>{}),
        );
}
