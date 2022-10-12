import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayingListPage extends Page<PlayingListState, Map<String, dynamic>> {
  static final String pageName = "PlayingListPage";
  PlayingListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlayingListState>(
              adapter: null, slots: <String, Dependent<PlayingListState>>{}),
          middleware: <Middleware<PlayingListState>>[],
        );
}
