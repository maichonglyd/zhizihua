import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRecommendComponent extends Component<GameRecommendState> {
  static final String componentName = "GameRecommendComponent";
  static final double componentItemHeight = 84.0;

  GameRecommendComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameRecommendState>(
                adapter: null,
                slots: <String, Dependent<GameRecommendState>>{
                }),);

  static double getComponentHeight(int length) {
    return 26 + (componentItemHeight * (length >= 3 ? 3 : length));
  }
}
