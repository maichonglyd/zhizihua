import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRewardListComponent extends Component<GameRewardListState> {
  static final String componentName = "GameRewardListComponent";
  GameRewardListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameRewardListState>(
                adapter: null,
                slots: <String, Dependent<GameRewardListState>>{
                }),);

}
