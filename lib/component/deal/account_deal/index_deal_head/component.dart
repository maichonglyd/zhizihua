import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexDealHeadComponent extends Component<IndexDealHeadState> {
  static final String componentName = "IndexDealHeadComponent";
  IndexDealHeadComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexDealHeadState>(
              adapter: null, slots: <String, Dependent<IndexDealHeadState>>{}),
        );
}
