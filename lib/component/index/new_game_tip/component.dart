import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewGameTipComponent extends Component<NewGameTipState> {
  static final String componentName = "NewGameTipComponent";
  NewGameTipComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<NewGameTipState>(
              adapter: null, slots: <String, Dependent<NewGameTipState>>{}),
        );
}
