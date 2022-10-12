import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountRecycleRecordPage
    extends Page<AccountRecycleRecordState, Map<String, dynamic>> {
  static final String pageName = "AccountRecycleRecordPage";
  AccountRecycleRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountRecycleRecordState>(
              adapter: null,
              slots: <String, Dependent<AccountRecycleRecordState>>{}),
          middleware: <Middleware<AccountRecycleRecordState>>[],
        );
}
