import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameFirstNewsComponent extends Component<GameFirstNewsState> {
  static final String componentName = "GameFirstNewsComponent";
  GameFirstNewsComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameFirstNewsState>(
                adapter: null,
                slots: <String, Dependent<GameFirstNewsState>>{
                }),);

}
