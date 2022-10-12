import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class MineTopTabComponent extends Component<MineTopTabState> {
  static final componentName = "MineTopTab";

  MineTopTabComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MineTopTabState>(
              adapter: null, slots: <String, Dependent<MineTopTabState>>{}),
        );
}
