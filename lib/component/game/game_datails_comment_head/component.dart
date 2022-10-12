import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCommentHeadComponent extends Component<GameCommentHeadState> {
  static final String componentName = "GameCommentHeadComponent";
  GameCommentHeadComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCommentHeadState>(
              adapter: null,
              slots: <String, Dependent<GameCommentHeadState>>{}),
        );
}
