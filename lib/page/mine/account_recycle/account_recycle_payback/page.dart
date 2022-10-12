import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/recycle_pro_order.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountRecyclePaybackPage
    extends Page<AccountRecyclePaybackState, RecycleProOrder> {
  AccountRecyclePaybackPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountRecyclePaybackState>(
              adapter: null,
              slots: <String, Dependent<AccountRecyclePaybackState>>{}),
          middleware: <Middleware<AccountRecyclePaybackState>>[],
        );
}
