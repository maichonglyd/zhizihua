import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class GameCommentItemComponent extends Component<GameCommentItemState> {
  static final String componentName = "GameCommentItemComponent";
  GameCommentItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCommentItemState>(
              adapter: null,
              slots: <String, Dependent<GameCommentItemState>>{}),
        );
}
