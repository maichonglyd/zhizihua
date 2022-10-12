import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCommentResponsePage
    extends Page<GameCommentResponseState, Map<String, dynamic>> {
  static final String pageName = "GameCommentResponsePage";

  GameCommentResponsePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCommentResponseState>(
              adapter: null,
              slots: <String, Dependent<GameCommentResponseState>>{}),
          middleware: <Middleware<GameCommentResponseState>>[],
        );
}
