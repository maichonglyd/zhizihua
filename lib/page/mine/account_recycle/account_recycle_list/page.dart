import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/effect.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/reducer.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/state.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/view.dart';

class AccountRecyclePage
    extends Page<AccountRecycleState, Map<String, dynamic>> {
  static final String pageName = "AccountRecyclePage";
  AccountRecyclePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountRecycleState>(
              adapter: null, slots: <String, Dependent<AccountRecycleState>>{}),
          middleware: <Middleware<AccountRecycleState>>[],
        );
}
