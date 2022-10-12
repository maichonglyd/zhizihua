import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PtzIncomePage extends Page<PtzIncomeState, Map<String, dynamic>> {
  static final String pageName = "PtzIncomePage";
  PtzIncomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PtzIncomeState>(
              adapter: null, slots: <String, Dependent<PtzIncomeState>>{}),
          middleware: <Middleware<PtzIncomeState>>[],
        );
}
