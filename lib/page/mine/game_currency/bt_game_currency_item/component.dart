import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCurrItemComponent extends Component<GameCurrItemState> {
  static final String componentName = "GameCurrItemComponent";
  GameCurrItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCurrItemState>(
              adapter: null, slots: <String, Dependent<GameCurrItemState>>{}),
        );
}
