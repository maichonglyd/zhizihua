import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountRecycleTipPage
    extends Page<AccountRecycleTipState, Map<String, dynamic>> {
  static final String pageName = "AccountRecycleTipPage";
  AccountRecycleTipPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountRecycleTipState>(
              adapter: null,
              slots: <String, Dependent<AccountRecycleTipState>>{}),
          middleware: <Middleware<AccountRecycleTipState>>[],
        );
}
