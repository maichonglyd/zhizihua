import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OpenVipPage extends Page<OpenVipState, Map<String, dynamic>>
    with WidgetsBindingObserverMixin {
  static final String pageName = "OpenVipPage";
  OpenVipPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OpenVipState>(
              adapter: null, slots: <String, Dependent<OpenVipState>>{}),
          middleware: <Middleware<OpenVipState>>[],
        );
}
