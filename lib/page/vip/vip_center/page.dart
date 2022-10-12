import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VipOpenPage extends Page<VipOpenState, Map<String, dynamic>> {
  static final String pageName = "VipOpenPage";
  VipOpenPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<VipOpenState>(
              adapter: null, slots: <String, Dependent<VipOpenState>>{}),
          middleware: <Middleware<VipOpenState>>[],
        );
}
