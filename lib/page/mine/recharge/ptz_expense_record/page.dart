import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PtbExpensePage extends Page<PtbExpenseState, Map<String, dynamic>> {
  static final String pageName = "PtbExpensePage";
  PtbExpensePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PtbExpenseState>(
              adapter: null, slots: <String, Dependent<PtbExpenseState>>{}),
          middleware: <Middleware<PtbExpenseState>>[],
        );
}
