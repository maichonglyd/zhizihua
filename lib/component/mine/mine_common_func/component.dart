import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MineCommonFuncComponent extends Component<MineCommonFuncState> {
  static final componentName = "MineCommonFunc";
  MineCommonFuncComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MineCommonFuncState>(
              adapter: null, slots: <String, Dependent<MineCommonFuncState>>{}),
        );
}
