import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexDealItemComponent extends Component<IndexDealItemState> {
  static final String componentName = "IndexDealItemComponent";
  IndexDealItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexDealItemState>(
              adapter: null, slots: <String, Dependent<IndexDealItemState>>{}),
        );
}
