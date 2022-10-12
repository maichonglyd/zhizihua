import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BTGameItemComponent extends Component<BTGameItemState> {
  static final String componentName = "BTGameItemComponent";
  BTGameItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BTGameItemState>(
              adapter: null, slots: <String, Dependent<BTGameItemState>>{}),
        );
}
