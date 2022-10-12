import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameNewBannerComponent extends Component<GameNewBannerState> {
  static final String componentName = "GameNewBannerComponent";

  GameNewBannerComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameNewBannerState>(
                adapter: null,
                slots: <String, Dependent<GameNewBannerState>>{
                }),);

}
