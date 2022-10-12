import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameFirstRoundComponent extends Component<GameFirstRoundState> {
  static final String componentName = "GameFirstRoundComponent";

  GameFirstRoundComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameFirstRoundState>(
                adapter: null,
                slots: <String, Dependent<GameFirstRoundState>>{
                }),);

  static double getComponentItemHeight(int isSdk) {
    if (isSdk == 2) {
      return 296.0 + 15;
    } else {
      return 246.0 + 15;
    }
  }

}
