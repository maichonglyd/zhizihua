import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameNewRoundListComponent extends Component<GameNewRoundListState> {
  GameNewRoundListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameNewRoundListState>(
                adapter: null,
                slots: <String, Dependent<GameNewRoundListState>>{
                }),);

}
