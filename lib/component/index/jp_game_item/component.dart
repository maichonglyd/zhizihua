import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class JPGameItemComponent extends Component<JPGameItemState> {
  JPGameItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<JPGameItemState>(
              adapter: null, slots: <String, Dependent<JPGameItemState>>{}),
        );
}
