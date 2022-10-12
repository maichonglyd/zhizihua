import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class InviteListPage extends Page<InviteListState, Map<String, dynamic>> {
  static final String pageName = "InviteListPage";
  InviteListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<InviteListState>(
              adapter: null, slots: <String, Dependent<InviteListState>>{}),
          middleware: <Middleware<InviteListState>>[],
        );
}
