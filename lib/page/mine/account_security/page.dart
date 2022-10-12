import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SecurityPage extends Page<SecurityState, Map<String, dynamic>> {
  static final String pageName = "SecurityPage";
  SecurityPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SecurityState>(
              adapter: null, slots: <String, Dependent<SecurityState>>{}),
          middleware: <Middleware<SecurityState>>[],
        );
}
