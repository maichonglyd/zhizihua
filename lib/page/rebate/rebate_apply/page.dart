import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// 返利申请列表页面
class RebateApplyPage extends Page<RebateApplyState, Map<String, dynamic>> {
  static final String pageName = "RebateApplyPage";
  RebateApplyPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RebateApplyState>(
              adapter: NoneConn<RebateApplyState>() + RebateGameListAdapter(),
              slots: <String, Dependent<RebateApplyState>>{}),
          middleware: <Middleware<RebateApplyState>>[],
        );
}
