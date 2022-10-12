import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameQualitySelectComponent extends Component<GameQualitySelectState> {
  static final String componentName = "GameQualitySelectComponent";
  GameQualitySelectComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameQualitySelectState>(
                adapter: null,
                slots: <String, Dependent<GameQualitySelectState>>{
                }),);

}
