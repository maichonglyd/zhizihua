import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexPlayedItemComponent extends Component<IndexPlayedItemState> {
  static final String componentName = "IndexPlayedItemComponent";
  IndexPlayedItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexPlayedItemState>(
              adapter: null,
              slots: <String, Dependent<IndexPlayedItemState>>{}),
        );
}
