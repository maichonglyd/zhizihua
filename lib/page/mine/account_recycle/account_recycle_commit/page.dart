import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountRecycleCommitPage
    extends Page<AccountRecycleCommitState, RecycleMg> {
  static final String pageName = "AccountRecycleCommitPage";
  AccountRecycleCommitPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountRecycleCommitState>(
              adapter: null,
              slots: <String, Dependent<AccountRecycleCommitState>>{}),
          middleware: <Middleware<AccountRecycleCommitState>>[],
        );
}
