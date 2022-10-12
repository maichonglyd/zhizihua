import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewGameReserveComponent extends Component<NewGameReserveState> {
  static final String componentName = "NewGameReserveComponent";
  NewGameReserveComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<NewGameReserveState>(
              adapter: null, slots: <String, Dependent<NewGameReserveState>>{}),
        );
}
