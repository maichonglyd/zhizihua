import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCommitCommentPage extends Page<GameCommitCommentState, int> {
  static final String pageName = "GameCommitCommentPage";
  GameCommitCommentPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCommitCommentState>(
              adapter: null,
              slots: <String, Dependent<GameCommitCommentState>>{}),
          middleware: <Middleware<GameCommitCommentState>>[],
        );
}
