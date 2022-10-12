import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RecruitmentOrderPage
    extends Page<RecruitmentOrderState, Map<String, dynamic>> {
  static final String pageName = "RecruitmentOrderPage";

  RecruitmentOrderPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RecruitmentOrderState>(
              adapter: null,
              slots: <String, Dependent<RecruitmentOrderState>>{}),
          middleware: <Middleware<RecruitmentOrderState>>[],
        );
}
