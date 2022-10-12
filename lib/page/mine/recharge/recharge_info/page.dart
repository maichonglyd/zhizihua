import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RechargeInfoPage extends Page<RechargeInfoState, Map<String, dynamic>> {
  static final String pageName = "RechargeInfoPage";
  RechargeInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RechargeInfoState>(
              adapter: null, slots: <String, Dependent<RechargeInfoState>>{}),
          middleware: <Middleware<RechargeInfoState>>[],
        );
}
