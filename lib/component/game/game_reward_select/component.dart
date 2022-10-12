import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRewardSelectComponent extends Component<GameRewardSelectState> {
  static final String componentName = "GameRewardSelectComponent";
  static const int typeStrategyMoney = 0;
  static const int typePlayerList = 1;

  GameRewardSelectComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameRewardSelectState>(
                adapter: null,
                slots: <String, Dependent<GameRewardSelectState>>{
                }),);

}
