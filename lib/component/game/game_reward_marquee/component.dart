import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRewardMarqueeComponent extends Component<GameRewardMarqueeState> {
  static final String componentName = "GameRewardMarqueeComponent";

  GameRewardMarqueeComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameRewardMarqueeState>(
                adapter: null,
                slots: <String, Dependent<GameRewardMarqueeState>>{
                }),);

}
