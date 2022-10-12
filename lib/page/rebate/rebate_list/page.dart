import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///申请返利记录列表
class RebateRecordListPage
    extends Page<RebateRecordListState, Map<String, dynamic>> {
  static final String pageName = "RebateRecordListPage";

  RebateRecordListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RebateRecordListState>(
              adapter: null,
              slots: <String, Dependent<RebateRecordListState>>{}),
          middleware: <Middleware<RebateRecordListState>>[],
        );
}
