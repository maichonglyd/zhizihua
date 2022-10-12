import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class MineFunListComponent extends Component<MineFunListState> {
  static final componentName = "MineFunList";
  MineFunListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MineFunListState>(
              adapter: null, slots: <String, Dependent<MineFunListState>>{}),
        );
}
