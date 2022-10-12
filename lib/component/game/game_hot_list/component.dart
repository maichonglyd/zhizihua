import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameHotListComponent extends Component<GameHotListState> {
  static final String componentName = "GameHotListComponent";

  GameHotListComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameHotListState>(
              adapter: null, slots: <String, Dependent<GameHotListState>>{}),
        );
}
