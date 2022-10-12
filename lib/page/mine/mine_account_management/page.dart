import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountManagePage extends Page<AccountManageState, Map<String, dynamic>> {
  static final String pageName = "AccountManagePage";
  AccountManagePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountManageState>(
              adapter: null, slots: <String, Dependent<AccountManageState>>{}),
          middleware: <Middleware<AccountManageState>>[],
        );
}
