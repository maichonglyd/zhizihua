import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameHotClassifyComponent extends Component<GameHotClassifyState> {
  static final String componentName = "GameHotClassifyComponent";
  GameHotClassifyComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameHotClassifyState>(
                adapter: null,
                slots: <String, Dependent<GameHotClassifyState>>{
                }),);

}
