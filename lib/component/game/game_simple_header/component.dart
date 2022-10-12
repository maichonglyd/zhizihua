import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameSimpleHeaderComponent extends Component<GameSimpleHeaderState> {
  static final String componentName = "GameSimpleHeaderComponent";

  GameSimpleHeaderComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameSimpleHeaderState>(
              adapter: null,
              slots: <String, Dependent<GameSimpleHeaderState>>{}),
        );
}
