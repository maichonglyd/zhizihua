import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FindPasswordPage extends Page<FindPasswordState, Map<String, dynamic>> {
  static final String pageName = "FindPasswordPage";
  FindPasswordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FindPasswordState>(
              adapter: null, slots: <String, Dependent<FindPasswordState>>{}),
          middleware: <Middleware<FindPasswordState>>[],
        );
}
