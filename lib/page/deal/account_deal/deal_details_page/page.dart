import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DealDetailsPage extends Page<DealDetailsState, int> {
  static final String pageName = "DealDetailsPage";
  DealDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealDetailsState>(
              adapter: null, slots: <String, Dependent<DealDetailsState>>{}),
          middleware: <Middleware<DealDetailsState>>[],
        );
}
