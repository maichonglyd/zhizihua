import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GmGameItemComponent extends Component<GmGameItemState> {
  static final String componentName = "GmGameItemComponent";
  GmGameItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GmGameItemState>(
              adapter: null, slots: <String, Dependent<GmGameItemState>>{}),
        );
}
