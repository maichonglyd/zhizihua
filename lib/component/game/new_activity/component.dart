import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewActivityComponent extends Component<NewActivityState> {
  static final String componentName = "NewActivityComponent";
  NewActivityComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<NewActivityState>(
              adapter: null, slots: <String, Dependent<NewActivityState>>{}),
        );
}
