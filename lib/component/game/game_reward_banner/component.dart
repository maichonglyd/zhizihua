import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRewardBannerComponent extends Component<GameRewardBannerState> {
  static final String componentName = "GameRewardBannerComponent";

  GameRewardBannerComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameRewardBannerState>(
              adapter: null,
              slots: <String, Dependent<GameRewardBannerState>>{}),
        );
}
