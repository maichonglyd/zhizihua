import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BindMobilePage extends Page<BindMobileState, Map<String, dynamic>> {
  static final String pageName = "BindMobilePage";
  BindMobilePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BindMobileState>(
              adapter: null, slots: <String, Dependent<BindMobileState>>{}),
          middleware: <Middleware<BindMobileState>>[],
        );
}
