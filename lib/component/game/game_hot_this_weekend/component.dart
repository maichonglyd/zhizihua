import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameHotThisWeekendComponent extends Component<GameHotThisWeekendState> {
  static final String componentName = "GameHotThisWeekendComponent";
  GameHotThisWeekendComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameHotThisWeekendState>(
                adapter: null,
                slots: <String, Dependent<GameHotThisWeekendState>>{
                }),);

}
