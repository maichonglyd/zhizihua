import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameNewNoticeComponent extends Component<GameNewNoticeState> {
  static final String componentName = "GameNewNoticeComponent";
  GameNewNoticeComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameNewNoticeState>(
                adapter: null,
                slots: <String, Dependent<GameNewNoticeState>>{
                }),);

}
